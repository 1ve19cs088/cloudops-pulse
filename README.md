# CloudOps Pulse 🛰️  
A real-time observability platform built on Kubernetes using Prometheus and Grafana — tailored for SRE/DevOps interviews and demos.

## 📦 Tech Stack

| Component     | Purpose                         |
|---------------|----------------------------------|
| Minikube      | Local Kubernetes Cluster         |
| Istio         | Service Mesh + Ingress Gateway   |
| Prometheus    | Metrics Collection               |
| Grafana       | Dashboards + Alerting            |
| Python Script | CPU Load Generator for Alerting  |

---

## 🌐 Live Microservices Setup

### Services:
- `frontend` → Returns "Hello from Frontend"
- `backend` → Returns "Hello from Backend"

### Access:
```bash
kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80

### Then visit:

http://localhost:8080/frontend

http://localhost:8080/backend

| Tool         | Status                         |
| ------------ | ------------------------------ |
| ✅ Prometheus | Metrics via kubelet + cAdvisor |
| ✅ Grafana    | Dashboards, Alerting           |
| ⏳ Loki/Tempo | Planned in next version        |


📈 Custom Alerting
Alert Rule (PrometheusRule):
Triggers if CPU > 10% for more than 1 minute.
xpr: rate(container_cpu_usage_seconds_total{namespace="sre-app"}[2m]) > 0.1

Tested With:python


# alert-test.py
import time, random
while True:
  [random.random()*random.random() for _ in range(10**6)]
  time.sleep(1)
Deployed as load-generator pod using Python image.

📏 SLO / SLI Definitions

📄 slo_definitions.md


- SLI: container_cpu_usage_seconds_total
- SLO: < 0.1 (10%) CPU for 95% of time
- Alert: Fires if CPU > 0.1 for > 1 min
🧠 RCA Sample
📄 rca-example.md


Incident: High CPU Usage
Root Cause: load-generator test pod
Impact: Triggered Prometheus alert
Resolution: Deleted pod manually
