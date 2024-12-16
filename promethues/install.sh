#!/bin/bash

helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring --values override_values.yaml --create-namespace