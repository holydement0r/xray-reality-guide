---
title: Xray Reality / 3x-ui configs and tools
description: Field notes and copy-paste configs for home-ISP IPs, Reality, routing and IP reputation
---

# Xray Reality / 3x-ui configs and tools

[中文](README.md) · **English**

Copy-paste configs and field notes for home-ISP IPs, Xray Reality, the 3x-ui panel, routing rules and Scamalytics reputation.

The tools and the full write-ups live at **[dementor.cn/en](https://dementor.cn/en/)** ([中文](https://dementor.cn/)). This repository holds only the configs and scripts you can copy.

## Online tools

Ten tools, **all computed in your browser — nothing is uploaded and no account is needed**. The one exception is the SNI checker: a browser cannot read the negotiated ALPN, so that handshake is made server-side, and the page states exactly what it looks up and what it does not record.

| Tool | What it does |
|---|---|
| [Reality config generator](https://dementor.cn/en/tools/reality-config/) | Generates a UUID, an x25519 keypair and a shortId, and exports both a 3x-ui inbound JSON and a `vless://` link |
| [Routing rule generator](https://dementor.cn/en/tools/routing-builder/) | Tick services, assign outbounds, and get Xray routing rules emitted in the order Xray evaluates them |
| [Xray config checker](https://dementor.cn/en/tools/config-check/) | Paste config.json: JSON syntax with line and column, then Reality parameters, sniffing, rule order and dangling outboundTag references |
| [Reality SNI checker](https://dementor.cn/en/tools/sni-check/) | Bulk-checks whether domains work as a `dest`: TLS 1.3, ALPN h2, CDN presence, handshake latency |
| [IP checker](https://dementor.cn/en/tools/ip-check/) | ASN, carrier and attribution, a datacenter-versus-residential verdict, a heuristic risk score, and a WebRTC leak check |
| [WebRTC leak test](https://dementor.cn/en/tools/webrtc-leak/) | Lists every ICE candidate against your exit IP, with per-browser instructions for turning it off |
| [vless:// link parser](https://dementor.cn/en/tools/vless-parser/) | Breaks a share link into UUID / SNI / pbk / sid / flow / fp with explanations, and flags what is missing |
| [Subscription parser](https://dementor.cn/en/tools/sub-parser/) | Batch-decodes base64 subscriptions and vmess / ss / trojan / vless links into one table |
| [Subscription converter](https://dementor.cn/en/tools/sub-convert/) | Converts a subscription to Clash (mihomo) YAML and sing-box JSON — **the subscription never reaches any server** |
| [VPS picker](https://dementor.cn/en/tools/vps-picker/) | Four questions (use case, budget, China routing, exit region) mapped to a specific provider and plan |

## Guides (condensed here; full versions on the site)

- [Home-ISP IP vs datacenter IP: why your node keeps getting flagged](https://holydement0r.github.io/xray-reality-guide/docs/home-isp-vs-datacenter.html)
- [Reading a Scamalytics score](https://holydement0r.github.io/xray-reality-guide/docs/scamalytics-score.html)
- [Choosing a US home-ISP / residential IP VPS](https://holydement0r.github.io/xray-reality-guide/docs/choosing-residential-vps.html)
- [Choosing a Reality SNI, with measured Apple domain results](https://holydement0r.github.io/xray-reality-guide/docs/reality-sni.html)
- [Zero to connected: the shortest 3x-ui + Reality path](https://holydement0r.github.io/xray-reality-guide/docs/quickstart.html)

> The condensed docs above are currently Chinese only. The full English versions are on the site, linked below.

## Full guides (dementor.cn/en)

**Choosing a machine**

- [Home-ISP IP vs datacenter IP](https://dementor.cn/en/home-isp-vs-datacenter/)
- [How to choose a US home-ISP VPS](https://dementor.cn/en/home-isp-vps-review/)
- [Provider directory](https://dementor.cn/en/vendors/) — plans, prices and route measurements re-run weekly
- [Reading a Scamalytics score](https://dementor.cn/en/scamalytics-score/)
- [Oracle Cloud Always Free for a proxy node](https://dementor.cn/en/oracle-free-vps/)

**Building**

- [Choosing a protocol: Reality / Hysteria2 / TUIC / AnyTLS / ShadowTLS](https://dementor.cn/en/protocol-comparison/)
- [Installing and hardening 3x-ui](https://dementor.cn/en/3x-ui-install/)
- [Xray Reality configuration explained](https://dementor.cn/en/xray-reality-config/)
- [Hysteria2 setup: masquerade, port hopping and UDP throttling](https://dementor.cn/en/hysteria2-install/)
- [sing-box as a server: several protocol inbounds in one config](https://dementor.cn/en/sing-box-server/)
- [Per-service routing](https://dementor.cn/en/gemini-routing/)
- [Cloudflare WARP as a secondary exit](https://dementor.cn/en/warp-unlock/)

**Troubleshooting**

- [Reality will not connect (context deadline exceeded, speed test -1)](https://dementor.cn/en/troubleshooting/reality-handshake-failed/)
- [Hysteria2 will not connect: establish UDP first](https://dementor.cn/en/troubleshooting/hysteria2-connect-failed/)
- [The 3x-ui panel will not open](https://dementor.cn/en/troubleshooting/3x-ui-panel-inaccessible/)
- [Certificate issuance failures: an acme.sh reference](https://dementor.cn/en/troubleshooting/acme-cert-failed/)

**Clients**

- [Client comparison: v2rayN / NekoRay / sing-box / the Clash family](https://dementor.cn/en/client-comparison/)
- [NekoBox on Android](https://dementor.cn/en/nekobox-guide/)

## What is in this repository

```
configs/
  routing-14services.json   # a complete Xray routing config for 14 services (geosite/geoip example)
scripts/
  sni-test.sh               # screen Reality SNI candidates from your own VPS
                            # (TLS 1.3 + h2 + no CDN + low handshake latency)
docs/
  reality-sni.md            # choosing an SNI, with measured Apple domain results
  quickstart.md             # zero to connected: the shortest 3x-ui + Reality path
  home-isp-vs-datacenter.md # the four classes of IP and how to check yours
  scamalytics-score.md      # reading a fraud score, and what it cannot tell you
  choosing-residential-vps.md
```

## Quick start

```bash
# 1. install 3x-ui (guide linked above)
bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)

# 2. screen SNI candidates from the box itself
#    (pick one with TLS 1.3 + h2 and low latency to use as dest)
bash scripts/sni-test.sh

# 3. generate keys and config with the online tool
#    https://dementor.cn/en/tools/reality-config/

# 4. copy configs/routing-14services.json, or tick services in the generator
#    https://dementor.cn/en/tools/routing-builder/
```

## The two traps everybody hits

1. **Do not use `www.microsoft.com` as the masquerade domain.** Its TLS implementation is incompatible with the way Reality borrows a certificate, so the handshake fails outright — the client never connects and the panel's speed test sits at `-1`, with nothing obvious in the logs. Use something like `www.icloud.com`. Target and SNI in the panel must be the same domain.
2. **Turn every post-quantum option off.** On 3x-ui v3.4.2 (bundling Xray 26.x), a new VLESS inbound may default its encryption field to `mlkem768x25519plus...`, and Reality may add an `mldsa65` signature. No shipping client supports these yet, so leaving them on guarantees failure. Set encryption back to `none`.

**Masquerade-domain conclusions go stale within days** — `www.apple.com` was usable on 2026-08-07 and sat behind Akamai when re-tested on 08-11. Do not copy someone else's list; run `scripts/sni-test.sh` or the [online SNI checker](https://dementor.cn/en/tools/sni-check/) against your own machine.

## License

MIT. Use the configs and scripts freely; you are on your own if something breaks.
