---
title: Reality SNI 怎么选 + Apple 域名实测
---

# Reality SNI 怎么选

Reality 的 `dest` / `serverNames` 要借一个真实的高质量 TLS 站点。选错了握手就失败，或者特征太明显被墙盯上。合格的目标要同时满足：

1. **TLS 1.3** —— Reality 靠它，不支持直接淘汰。
2. **ALPN 支持 h2** —— HTTP/2，主流大站都有。
3. **不在 CDN 后面** —— Cloudflare / Akamai / Fastly 回源特征乱，且很多人共用，容易撞。响应头带 `cf-ray`、`x-akamai`、`server: cloudflare` 的直接排除。
4. **握手延迟低** —— 从你自己的 VPS 到目标的 `time_appconnect` 越低越好，几十毫秒最佳。
5. **域名冷门一点** —— 太热门（如 `www.microsoft.com`）大家都用，反而是特征。

用仓库里的 `scripts/sni-test.sh` 从你的 VPS 上一次性筛：

```bash
bash scripts/sni-test.sh
```

输出每个候选的 `tls` / `alpn` / 握手耗时 / 响应头，一眼看出谁能用。

## Apple 域名实测淘汰表

很多人只会说"用 apple 的域名"，但 Apple 一半的域名不能用。从一台美西 VPS 实测的结果：

| 域名 | 能用? | 原因 |
|---|---|---|
| `www.icloud.com` | ✅ 推荐默认 | 0.20s 握手，h2，响应头干净 |
| `machinelearning.apple.com` | ✅ | 够冷门 |
| `www.apple.com` | ✅ | 可用 |
| `swdist.apple.com` | ✅ | 可用 |
| `developer.apple.com` | ❌ | CDN 后面 |
| `support.apple.com` | ❌ | CDN 后面 |
| `images.apple.com` | ⚠️ | 自测，可能走 CDN |
| `itunes.apple.com` | ⚠️ | 自测 |

结论：`dest` 默认用 `www.icloud.com:443`。但**别照抄** —— 不同机房到各域名的延迟不一样，一定在自己机器上跑一遍 `sni-test.sh` 再定。

完整原理和排查（握手失败、`context deadline exceeded`、测速 -1）见 <https://dementor.cn/reality-handshake-failed/>。
