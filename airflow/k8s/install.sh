#!/bin/bash

## set the release-name & namespace
export AIRFLOW_NAME="khc-airflow"
export AIRFLOW_NAMESPACE="hrs"

## create the namespace
kubectl delete ns "$AIRFLOW_NAMESPACE"
kubectl create ns "$AIRFLOW_NAMESPACE"

## install using helm 3
helm install \
  "$AIRFLOW_NAME" \
  airflow-helm/airflow \
  --namespace "$AIRFLOW_NAMESPACE" \
  --values ./values.yaml
  
## wait until the above command returns and resources become ready 
## (may take a while)