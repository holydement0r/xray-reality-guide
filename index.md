---
title: Xray Reality / 3x-ui 配置与工具
description: 家宽 IP、Reality、分流与纯净度的实战笔记与可复制配置
---

家宽 IP、Xray Reality、3x-ui 面板、分流规则与 Scamalytics 纯净度的实战笔记、可直接抄的配置，以及十个浏览器本地运算的在线工具。

完整教程在 **[dementor.cn](https://dementor.cn/)** · Full English guides at **[dementor.cn/en](https://dementor.cn/en/)** · [仓库源码 / source](https://github.com/holydement0r/xray-reality-guide)

## 在线工具 · Online tools

全部在浏览器本地运算，不上传参数，免注册。All computed in your browser — nothing uploaded, no account.

| 工具 | Tool | 作用 |
|---|---|---|
| [Reality 配置生成器](https://dementor.cn/tools/reality-config/) | [Reality config generator](https://dementor.cn/en/tools/reality-config/) | UUID、x25519 密钥对、shortId，导出 3x-ui JSON 与 `vless://` |
| [分流规则生成器](https://dementor.cn/tools/routing-builder/) | [Routing rule generator](https://dementor.cn/en/tools/routing-builder/) | 勾服务出 routing JSON，顺序自动排好 |
| [配置校验器](https://dementor.cn/tools/config-check/) | [Config checker](https://dementor.cn/en/tools/config-check/) | JSON 语法定位 + Reality 参数 + 规则顺序 + 悬空 outboundTag |
| [SNI 检测](https://dementor.cn/tools/sni-check/) | [SNI checker](https://dementor.cn/en/tools/sni-check/) | TLS 1.3 / ALPN h2 / 是否套 CDN / 握手耗时 |
| [IP 检测](https://dementor.cn/tools/ip-check/) | [IP checker](https://dementor.cn/en/tools/ip-check/) | ASN、归属、机房 vs 住宅初判、WebRTC 泄露 |
| [WebRTC 泄露检测](https://dementor.cn/tools/webrtc-leak/) | [WebRTC leak test](https://dementor.cn/en/tools/webrtc-leak/) | 列出 ICE candidate 并与出口 IP 比对 |
| [vless 链接解析](https://dementor.cn/tools/vless-parser/) | [vless parser](https://dementor.cn/en/tools/vless-parser/) | 拆出每个参数并标出缺失项 |
| [订阅解析](https://dementor.cn/tools/sub-parser/) | [Subscription parser](https://dementor.cn/en/tools/sub-parser/) | base64 / vmess / ss / trojan / vless 批量解码 |
| [订阅转换](https://dementor.cn/tools/sub-convert/) | [Subscription converter](https://dementor.cn/en/tools/sub-convert/) | 转 Clash YAML 与 sing-box JSON，订阅不经服务器 |
| [选购决策器](https://dementor.cn/tools/vps-picker/) | [VPS picker](https://dementor.cn/en/tools/vps-picker/) | 按用途 / 预算 / 线路 / 落地推荐套餐 |

## 本站精简指南

- [家宽 IP vs 机房 IP：为什么节点总被识别](docs/home-isp-vs-datacenter.html)
- [Scamalytics 分数怎么看：多少分算能用](docs/scamalytics-score.html)
- [美国家宽 / 住宅 IP VPS 怎么选](docs/choosing-residential-vps.html)
- [Reality SNI 怎么选 + Apple 域名实测淘汰表](docs/reality-sni.html)
- [从 0 到能连：3x-ui + Reality 最短路径](docs/quickstart.html)

## 完整教程

**中文** —— [协议怎么选](https://dementor.cn/protocol-comparison/) · [3x-ui 安装与加固](https://dementor.cn/3x-ui-install/) · [Reality 配置详解](https://dementor.cn/xray-reality-config/) · [Hysteria2 搭建](https://dementor.cn/hysteria2-install/) · [sing-box 服务端](https://dementor.cn/sing-box-server/) · [分流配置](https://dementor.cn/gemini-routing/) · [报错排查](https://dementor.cn/troubleshooting/) · [商家目录](https://dementor.cn/vendors/) · [全部文章](https://dementor.cn/posts/)

**English** —— [Choosing a protocol](https://dementor.cn/en/protocol-comparison/) · [Installing 3x-ui](https://dementor.cn/en/3x-ui-install/) · [Reality configuration](https://dementor.cn/en/xray-reality-config/) · [Hysteria2 setup](https://dementor.cn/en/hysteria2-install/) · [sing-box server](https://dementor.cn/en/sing-box-server/) · [Per-service routing](https://dementor.cn/en/gemini-routing/) · [Troubleshooting](https://dementor.cn/en/troubleshooting/) · [Providers](https://dementor.cn/en/vendors/) · [All articles](https://dementor.cn/en/posts/)

## 两个最常见的坑

1. **伪装域名别用 `www.microsoft.com`** —— TLS 实现和 Reality 借证书的机制不兼容，握手直接失败，表现是一直连不上、测速永远 `-1`，日志里却看不出问题。
2. **后量子选项全部关掉** —— 3x-ui v3.4.2（Xray 26.x）新建 VLESS 入站时「加密」可能默认选成 `mlkem768x25519plus...`，现网客户端全都还不支持，开着必然连不上。改回 `none`。

伪装域名的结论几天就会变（`www.apple.com` 08-07 还能用，08-11 已在 Akamai 后面）。别抄列表，用 [`scripts/sni-test.sh`](https://github.com/holydement0r/xray-reality-guide/blob/main/scripts/sni-test.sh) 或 [在线 SNI 检测](https://dementor.cn/tools/sni-check/) 在自己机器上跑。

MIT License · 配置和脚本随便用，出问题自己负责。
