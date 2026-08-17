---
title: Xray Reality / 3x-ui 配置与工具
description: 家宽 IP、Reality、分流与纯净度的实战笔记与可复制配置
---

# Xray Reality / 3x-ui 搭建配置与工具

**中文** · [English](README.en.md)

家宽 IP、Xray Reality、3x-ui 面板、分流规则与 Scamalytics 纯净度的实战笔记与可直接用的配置。

配套在线工具与完整教程在 **[dementor.cn](https://dementor.cn/)**（[English](https://dementor.cn/en/)），本仓库只放可复制的配置模板和脚本。

## 在线工具

十个工具，**全部在浏览器本地运算，不上传任何参数，免注册**。唯一例外是 SNI 检测 —— 浏览器读不到协商出来的 ALPN，只能从服务端发起握手，页面上写明了它查什么、不记什么。

| 工具 | 作用 |
|---|---|
| [Reality 配置生成器](https://dementor.cn/tools/reality-config/) | 生成 UUID / x25519 密钥对 / shortId，直接产出 3x-ui JSON 与 `vless://` 链接 |
| [分流规则生成器](https://dementor.cn/tools/routing-builder/) | 勾服务生成 Xray routing 规则，自动按优先级排序 |
| [Xray 配置校验器](https://dementor.cn/tools/config-check/) | 粘贴 config.json：JSON 语法定位 + Reality 参数 + 规则顺序 + outboundTag 悬空引用 |
| [Reality SNI 检测](https://dementor.cn/tools/sni-check/) | 批量测域名能不能当 dest：TLS 1.3 / ALPN h2 / 是否套 CDN / 握手耗时 |
| [IP 检测](https://dementor.cn/tools/ip-check/) | 查 ASN / 运营商 / 归属，机房 vs 住宅初判，启发式风险分，WebRTC 泄露自查 |
| [WebRTC 泄露检测](https://dementor.cn/tools/webrtc-leak/) | 列出全部 ICE candidate 并与出口 IP 比对，附各浏览器关闭方法 |
| [vless:// 链接解析器](https://dementor.cn/tools/vless-parser/) | 拆出 UUID / SNI / pbk / sid / flow / fp 每个参数并解释，标出缺失项 |
| [订阅链接解析器](https://dementor.cn/tools/sub-parser/) | base64 订阅与 vmess / ss / trojan / vless 链接批量解码成表 |
| [订阅转换器](https://dementor.cn/tools/sub-convert/) | 订阅转 Clash (mihomo) YAML 与 sing-box JSON，**订阅内容不经过任何服务器** |
| [VPS 选购决策器](https://dementor.cn/tools/vps-picker/) | 按用途 / 预算 / 回国线路 / 落地地区推荐具体套餐 |

## 指南（本仓库精简版，完整版在站上）

- [家宽 IP vs 机房 IP：为什么节点总被识别](https://holydement0r.github.io/xray-reality-guide/docs/home-isp-vs-datacenter.html)
- [Scamalytics 分数怎么看：多少分算能用](https://holydement0r.github.io/xray-reality-guide/docs/scamalytics-score.html)
- [美国家宽 / 住宅 IP VPS 怎么选](https://holydement0r.github.io/xray-reality-guide/docs/choosing-residential-vps.html)
- [Reality SNI 怎么选 + Apple 域名实测淘汰表](https://holydement0r.github.io/xray-reality-guide/docs/reality-sni.html)
- [从 0 到能连：3x-ui + Reality 最短路径](https://holydement0r.github.io/xray-reality-guide/docs/quickstart.html)

## 完整教程（dementor.cn）

**选机**

- [家宽 IP vs 机房 IP 到底差在哪](https://dementor.cn/home-isp-vs-datacenter/)
- [美国家宽 VPS 怎么选：主流商家横评](https://dementor.cn/home-isp-vps-review/)
- [家宽/住宅 IP 商家目录（逐家线路/套餐/价格，含每周自动重测的实测表）](https://dementor.cn/vendors/)
- [Scamalytics 分数怎么看、多少分能用](https://dementor.cn/scamalytics-score/)
- [甲骨文免费 VPS 搭节点：两层防火墙的坑](https://dementor.cn/oracle-free-vps/)

**搭建**

- [协议怎么选：Reality / Hysteria2 / TUIC / AnyTLS / ShadowTLS](https://dementor.cn/protocol-comparison/)
- [3x-ui 安装与面板加固](https://dementor.cn/3x-ui-install/)
- [Xray Reality 配置详解：参数含义与排查清单](https://dementor.cn/xray-reality-config/)
- [Hysteria2 搭建：伪装、端口跳跃与 UDP 被限速排查](https://dementor.cn/hysteria2-install/)
- [sing-box 服务端：一份配置开多个协议入站](https://dementor.cn/sing-box-server/)
- [分流配置：让指定域名走指定节点](https://dementor.cn/gemini-routing/)
- [Cloudflare WARP 二级出口](https://dementor.cn/warp-unlock/)

**排错**

- [Reality 连不上（context deadline exceeded / 测速 -1）](https://dementor.cn/troubleshooting/reality-handshake-failed/)
- [Hysteria2 连不上：先判 UDP 再看报错](https://dementor.cn/troubleshooting/hysteria2-connect-failed/)
- [3x-ui 面板打不开（连接被拒 / 502 / 忘记端口和访问路径）](https://dementor.cn/troubleshooting/3x-ui-panel-inaccessible/)
- [证书申请失败：acme.sh 常见报错对照](https://dementor.cn/troubleshooting/acme-cert-failed/)

**客户端**

- [客户端横评：v2rayN / NekoRay / sing-box / Clash 系](https://dementor.cn/client-comparison/)
- [NekoBox 安卓使用教程（导入 / 分流 / TUN / 排查）](https://dementor.cn/nekobox-guide/)

新文章更新在 [dementor.cn](https://dementor.cn/)，也可以用 RSS 订阅：`https://dementor.cn/feed.xml`

## 仓库内容

```
configs/
  routing-14services.json   # 14 个服务分流的完整 Xray 配置（geosite/geoip 分流示例）
scripts/
  sni-test.sh               # 从你的 VPS 筛选可用的 Reality SNI（TLS1.3 + h2 + 无 CDN + 低握手延迟）
docs/
  reality-sni.md            # SNI 怎么选、Apple 域名实测淘汰表
  quickstart.md             # 从 0 到能连：3x-ui + Reality 最短路径
  home-isp-vs-datacenter.md # 四类 IP 的区别与自己检测的方法
  scamalytics-score.md      # 诈骗分怎么读，以及它不能告诉你什么
  choosing-residential-vps.md
```

## 快速开始

```bash
# 1. 装 3x-ui（教程见上）
bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)

# 2. 在本机筛 SNI（选一个 TLS1.3 + h2 + 低延迟的域名当 dest）
bash scripts/sni-test.sh

# 3. 用在线工具生成密钥和配置
#    https://dementor.cn/tools/reality-config/

# 4. 分流规则直接抄 configs/routing-14services.json，或用生成器勾选
#    https://dementor.cn/tools/routing-builder/
```

## 两个最常见的坑

1. **伪装域名别用 `www.microsoft.com`。** 它的 TLS 实现和 Reality 借证书的机制不兼容，握手直接失败，表现是客户端一直连不上、面板测速永远 `-1`，日志里却看不出问题。用 `www.icloud.com` 这类。面板里 Target 和 SNI 必须填同一个域名。
2. **后量子选项全部关掉。** 3x-ui v3.4.2（自带 Xray 26.x）新建 VLESS 入站时，「加密」可能默认选成 `mlkem768x25519plus...`，Reality 也可能带 `mldsa65` 签名。现网客户端全都还不支持，开着必然连不上。把「加密」改回 `none`。

**伪装域名的结论几天就会变** —— `www.apple.com` 2026-08-07 还能用，08-11 复测已经在 Akamai 后面了。别抄别人的列表，用 `scripts/sni-test.sh` 或[在线 SNI 检测](https://dementor.cn/tools/sni-check/)在自己机器上跑一遍。

## License

MIT。配置和脚本随便用，出问题自己负责。
