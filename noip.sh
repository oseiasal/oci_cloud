#!/bin/bash

# Obter IP público
MYIP=$(dig +short myip.opendns.com @resolver1.opendns.com)

# Carregar variáveis de ambiente do arquivo .env
source /home/ubuntu/.env

# Atualizar no No-IP
curl -s --user-agent "OsBot/1.0 (oseias@oseias.com)" \
"https://$NO_IP_USER:$NO_IP_PASS@dynupdate.no-ip.com/nic/update?hostname=$NO_IP_URL&myip=$MYIP"

#Atualizar no cloudflare
curl -s https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$DNS_RECORD_ID \
    -X PUT \
    -H 'Content-Type: application/json' \
    -H "X-Auth-Email: $CLOUDFLARE_EMAIL" \
    -H "Authorization: $CLOUDFLARE_API_KEY" \
  -d "{
    \"comment\": \"Update domain via script\",
    \"content\": \"$MYIP\",
    \"name\": \"$MY_URL\",
    \"proxied\": false,
    \"ttl\": 3600,
    \"type\": \"A\"
  }"