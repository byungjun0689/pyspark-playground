#!/bin/bash

helm upgrade --install loki-stack grafana/loki-stack --values override-values.yaml -n monitoring --create-namespace
