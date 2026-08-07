# Xray Reality / 3x-ui 搭建配置与工具

家宽 IP、Xray Reality、3x-ui 面板、分流规则与 Scamalytics 纯净度的实战笔记与可直接用的配置。

配套在线工具与完整教程在 **[dementor.cn](https://dementor.cn/)**，本仓库只放可复制的配置模板和脚本。

## 在线工具

| 工具 | 作用 |
|---|---|
| [Reality 配置生成器](https://dementor.cn/tools/reality-config/) | 生成 UUID / x25519 密钥对 / shortId，直接产出 3x-ui JSON 与 `vless://` 链接 |
| [分流规则生成器](https://dementor.cn/tools/routing-builder/) | 勾服务生成 Xray routing 规则，自动按优先级排序 |
| [IP 检测](https://dementor.cn/tools/ip-check/) | 查 ASN / 运营商 / 归属，机房 vs 住宅初判，启发式风险分，WebRTC 泄露自查 |

## 指南（本仓库精简版，完整版在站上）

- [家宽 IP vs 机房 IP：为什么节点总被识别](docs/home-isp-vs-datacenter.md)
- [Scamalytics 分数怎么看：多少分算能用](docs/scamalytics-score.md)
- [美国家宽 / 住宅 IP VPS 怎么选](docs/choosing-residential-vps.md)
- [Reality SNI 怎么选 + Apple 域名实测淘汰表](docs/reality-sni.md)
- [从 0 到能连：3x-ui + Reality 最短路径](docs/quickstart.md)

## 完整教程（dementor.cn）

- [3x-ui 安装与面板加固](https://dementor.cn/3x-ui-install/)
- [Reality 握手失败排查（context deadline exceeded / 测速 -1）](https://dementor.cn/reality-handshake-failed/)
- [Scamalytics 分数怎么看、多少分能用](https://dementor.cn/scamalytics-score/)
- [家宽 IP vs 机房 IP 到底差在哪](https://dementor.cn/home-isp-vs-datacenter/)
- [美国家宽 VPS 怎么选：主流商家横评](https://dementor.cn/home-isp-vps-review/)
- [家宽/住宅 IP 商家目录（逐家线路/套餐/价格）](https://dementor.cn/vendors/)

## 仓库内容

```
configs/
  routing-14services.json   # 14 个服务分流的完整 Xray 配置（geosite/geoip 分流示例）
scripts/
  sni-test.sh               # 从你的 VPS 筛选可用的 Reality SNI（TLS1.3 + h2 + 无 CDN + 低握手延迟）
docs/
  reality-sni.md            # SNI 怎么选、Apple 域名实测淘汰表
  quickstart.md             # 从 0 到能连：3x-ui + Reality 最短路径
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

## License

MIT。配置和脚本随便用，出问题自己负责。
