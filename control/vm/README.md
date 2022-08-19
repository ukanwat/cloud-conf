The Victoria Metrics write api can be accessed via port 8480 with the following DNS name from within your cluster:
vm-victoria-metrics-cluster-vminsert.vm.svc.cluster.local

Get the Victoria Metrics insert service URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace vm -l "app=vminsert" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace vm port-forward $POD_NAME 8480

You need to update your Prometheus configuration file and add the following lines to it:

prometheus.yml

    remote_write:
      - url: "http://<insert-service>/insert/0/prometheus/"



for example -  inside the Kubernetes cluster:

    remote_write:
      - url: "http://vmcluster-victoria-metrics-cluster-vminsert.vm.svc.cluster.local:8480/insert/0/prometheus/"
Read API:

The VictoriaMetrics read api can be accessed via port 8481 with the following DNS name from within your cluster:
vmcluster-victoria-metrics-cluster-vmselect.vm.svc.cluster.local

Get the VictoriaMetrics select service URL by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace vm -l "app=vmselect" -o jsonpath="{.items[0].metadata.name}")
  kubectl --namespace vm port-forward $POD_NAME 8481

You need to specify select service URL into your Grafana:
 NOTE: you need to use the Prometheus Data Source

Input this URL field into Grafana

    http://<select-service>/select/0/prometheus/


for example - inside the Kubernetes cluster:

    http://vmcluster-victoria-metrics-cluster-vmselect.vm.svc.cluster.local:8481/select/0/prometheus/