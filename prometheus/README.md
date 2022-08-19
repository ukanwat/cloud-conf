https://grafana.com/docs/grafana-cloud/kubernetes/prometheus/remote_write_helm_operator/

kubectl create secret generic vmpromsecret \
  --from-literal=username=109423\
  --from-literal=password='de1bEFG4fKn35HAJDSbC4Hf7XhB02JeO7vF3DRw7YhDCF9hSdH23u6b0dwb31yd6g8e3y2yqwd'\
  -n default