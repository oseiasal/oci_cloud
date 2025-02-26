MYIP=$(dig +short myip.opendns.com @resolver1.opendns.com) && \
curl --user-agent "OsBot/1.0 (oseias@oseias.com)" \

source .env

https://$NO_IP_USER:$NO_IP_PASS@dynupdate.no-ip.com/nic/update?hostname=$NO_IP_URL&myip=$MYIP &



