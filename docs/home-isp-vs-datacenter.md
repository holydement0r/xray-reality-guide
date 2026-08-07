# 家宽 IP vs 机房 IP：为什么节点总被识别

节点被平台风控识别、账号被封，十有八九是 IP 的问题。搞清楚"住宅（家宽）IP"和"机房 IP"的区别，是买机器前必须懂的一件事。

## 风控主要看三样

1. **ASN 归属** —— 最关键。IP 段登记在谁名下：
   - 登记在 **AT&T、Comcast、Verizon、Spectrum** 这类家庭宽带运营商 → **住宅 IP**
   - 登记在 **Cogent、GTT、DigitalOcean、Vultr、Linode** 这类骨干网/云厂商 → **机房 IP**
2. **rDNS（反向解析）** —— 住宅 IP 通常解析成 `c-73-x-x-x.hsd1.ca.comcast.net` 这种带 ISP 和地区标识的；机房常常是 `vps-12345.provider.com` 或干脆没有。
3. **商业 IP 情报库** —— MaxMind、IPinfo、Spur 这些库有自己的标注，风控厂商买的就是这个。这也是为什么有些"看起来是住宅"的 IP 仍被识别 —— 库里标成了 hosting。

## 两个反常识的点

- **机房 IP ≠ 一定高风险。** 一个信誉干净、没进滥用库的机房/专线 IP，在 Scamalytics 上照样可能是低分、照样能稳定用。别看到"机房"就劝退。
- **住宅 IP ≠ 一定低风险。** 归属是归属，信誉是信誉。最终能不能用，看的是信誉分。

## 怎么自己验一台机器

1. 查 ASN，看归属是家庭运营商还是机房 —— 用 [IP 检测工具](https://dementor.cn/tools/ip-check/)
2. 看 Scamalytics 分数 —— 见 [Scamalytics 分数怎么看](https://dementor.cn/scamalytics-score/)
3. 查 rDNS：`dig -x <IP> +short`

---

**完整版（含双 ISP 是什么、为什么有些"家宽"只有一个维度是 ISP）：**
<https://dementor.cn/home-isp-vs-datacenter/>

选购对照：[家宽/住宅 IP 商家目录](https://dementor.cn/vendors/)
