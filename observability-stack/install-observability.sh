#!/bin/bash

set -e

echo "🔧 Creating 'observability' namespace..."
kubectl create ns observability || true

echo "📦 Adding Helm repos..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

echo "📈 Installing Prometheus..."
helm install prometheus prometheus-community/kube-prometheus-stack \
  -n observability \
  --set grafana.enabled=false

echo "📊 Installing Grafana..."
helm install grafana grafana/grafana \
  -n observability \
  --set adminPassword='admin' \
  --set service.type=NodePort \
  --set persistence.enabled=false

#For further usage
# echo "📄 Installing Loki + Promtail..."
# helm install loki grafana/loki-stack \
#   -n observability \
#   --set promtail.enabled=true \
#   --set grafana.enabled=false

# echo "🔍 Installing Tempo..."
# helm install tempo grafana/tempo \
#   -n observability \
#   --set traces.otlp.grpc.enabled=true \
#   --set traces.otlp.http.enabled=true

echo "✅ Observability stack deployed!"
