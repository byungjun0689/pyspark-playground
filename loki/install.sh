#!/bin/bash

wget https://raw.githubusercontent.com/grafana/loki/v3.0.0/production/docker-compose.yaml -O docker-compose.yaml

echo "\n\nnetworks:\n  khc-logging-system-network:\n    external: true" >> docker-compose.yaml 
sed -i '' 's/- loki/- khc-logging-system-network/g' docker-compose.yaml

docker network inspect khc-logging-system-network >/dev/null 2>&1 || \
docker network create --driver bridge khc-logging-system-network

#docker compose up -d 