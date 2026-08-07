# 从 0 到能连：3x-ui + Reality 最短路径

假设你已经有一台 VPS（家宽 / 双 ISP / 机房都行，能不能过风控看 IP 信誉，不看归属本身 —— 详见
<https://dementor.cn/home-isp-vs-datacenter/>）。

## 1. 装 3x-ui 面板

```bash
bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
```

装完先做加固（改端口、开 BasicAuth、上 TLS），别裸奔在公网。步骤见
<https://dementor.cn/3x-ui-install/>。

## 2. 选 SNI

```bash
bash scripts/sni-test.sh
```

挑一个 `tls=TLSv1.3`、`alpn=h2`、握手最快、响应头不带 CDN 特征的域名。默认
`www.icloud.com:443` 一般能用。原理见 [reality-sni.md](reality-sni.md)。

## 3. 生成密钥和配置

浏览器打开 <https://dementor.cn/tools/reality-config/>：

- 生成 UUID
- 生成 x25519 密钥对（公钥填面板，私钥留着）
- 生成 shortId

工具直接产出 3x-ui 能贴的 JSON 和客户端 `vless://` 链接。

## 4. 分流

抄 `configs/routing-14services.json`，或用
<https://dementor.cn/tools/routing-builder/> 勾选你要分流的服务。规则会自动按优先级排序，
避免宽规则盖掉窄规则。

## 5. 验证配置合法

上传到 VPS 后，测一遍再重载：

```bash
# 3x-ui 自带的 xray 二进制通常在这
/usr/local/x-ui/bin/xray-linux-amd64 run -test -c your-config.json
```

看到 `Configuration OK.` 才算过。报错就对着行号查 geosite/geoip 标签有没有拼错。

## 常见卡点

- **连不上 / `context deadline exceeded`**：多半是 SNI 选错或 dest 不可达 →
  <https://dementor.cn/reality-handshake-failed/>
- **测速 -1**：同上，握手没完成
- **IP 被平台标记**：换 IP，或先用 [IP 检测工具](https://dementor.cn/tools/ip-check/) 看信誉，
  权威分以 Scamalytics / IPQualityScore / Spur 为准
