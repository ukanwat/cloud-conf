### Loki
Verify the application is working by running these commands:
kubectl --namespace loki port-forward service/loki 3100
curl http://127.0.0.1:3100/api/prom/label