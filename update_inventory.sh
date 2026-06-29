#!/bin/bash

cd terraform/

WEB_IPS=$(terraform output -json webserver_public_ips | python3 -c "import json,sys; ips=json.load(sys.stdin); print(ips[0]); print(ips[1])")
DB_IP=$(terraform output -raw dbserver_public_ip)

WEB1=$(echo "$WEB_IPS" | sed -n '1p')
WEB2=$(echo "$WEB_IPS" | sed -n '2p')

cd ..

cat > ansible/inventory.ini << EOF
[webservers]
webserver-1 ansible_host=$WEB1
webserver-2 ansible_host=$WEB2

[dbservers]
dbserver ansible_host=$DB_IP
EOF

echo "inventory.ini updated"
echo "webserver-1: $WEB1"
echo "webserver-2: $WEB2"
echo "dbserver:    $DB_IP"