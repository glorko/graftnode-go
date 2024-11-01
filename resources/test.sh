#!/bin/bash

echo "Initial HAProxy servers config..."
curl -s -u admin:mypassword http://localhost:5555/v3/services/haproxy/configuration/backends/service-backend/servers | jq .

echo -e "\nTesting cold start..."
echo -n "Response: "
curl -w "\nDNS: %{time_namelookup}s\nConnect: %{time_connect}s\nAppCon: %{time_appconnect}s\nPreTrans: %{time_pretransfer}s\nRedirect: %{time_redirect}s\nStartTrans: %{time_starttransfer}s\nTotal: %{time_total}s\n" localhost/hello

sleep 5

echo -e "\nHAProxy servers config after first request..."
curl -s -u admin:mypassword http://localhost:5555/v3/services/haproxy/configuration/backends/service-backend/servers | jq .

sleep 2

echo -e "\nTesting warm service..."
echo -n "Response: "
curl -w "\nDNS: %{time_namelookup}s\nConnect: %{time_connect}s\nAppCon: %{time_appconnect}s\nPreTrans: %{time_pretransfer}s\nRedirect: %{time_redirect}s\nStartTrans: %{time_starttransfer}s\nTotal: %{time_total}s\n" localhost/hello
echo