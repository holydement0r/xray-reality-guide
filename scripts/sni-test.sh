#!/bin/bash
# Screen SNI candidates from this VPS: TLS1.3 + h2 + no CDN + low handshake latency.
for d in www.apple.com www.icloud.com swdist.apple.com itunes.apple.com \
         developer.apple.com support.apple.com images.apple.com machinelearning.apple.com; do
  proto=$(openssl s_client -connect "$d:443" -servername "$d" -tls1_3 -alpn h2 </dev/null 2>/dev/null \
          | grep -E '^\s*Protocol\s*:' | head -1 | awk '{print $NF}')
  alpn=$(openssl s_client -connect "$d:443" -servername "$d" -tls1_3 -alpn h2 </dev/null 2>/dev/null \
          | grep -i 'ALPN protocol' | head -1 | awk '{print $NF}')
  hdr=$(curl -sI --max-time 8 "https://$d" 2>/dev/null | grep -iE '^(server|cf-ray|x-akamai|x-cache|via):' | tr -d '\r' | paste -sd'; ')
  t=$(curl -s -o /dev/null --max-time 8 -w '%{time_appconnect}' "https://$d" 2>/dev/null)
  printf '%-32s tls=%-8s alpn=%-6s hs=%-8s %s\n' "$d" "${proto:-FAIL}" "${alpn:-none}" "${t:-x}" "${hdr:0:70}"
done
