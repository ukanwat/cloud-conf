# Useful commands for deploying platform

#### Add prometheus operator (Setup)
```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update
```
#### Install prometheus chart
```sh
helm install prometheus prometheus-community/kube-prometheus-stack -n default -f values.yaml
kubectl apply -f servicemonitor.yaml
```
#### Monitoring dashboards
```sh
kc port-forward prometheus-prometheus-kube-prometheus-prometheus-0  9090
-or- kc port-forward -n default svc/prometheus-operated 9090
kc port-forward deployment/prometheus-grafana 3000 
```
### Setup Ingress
#### Add helm ingress-nginx repo (Setup)
```sh
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```
#### Install ingress-nginx
```sh
helm install ingress-nginx ingress-nginx/ingress-nginx
```
#### Install ingress
important - Configure location in ingress.yaml.
Can read more info at https://kubernetes.io/docs/concepts/services-networking/ingress/#tls
```sh
kc apply -f ingress.yaml
```
### Secure Ingress
can also follow https://getbetterdevops.io/k8s-ingress-with-letsencrypt/
#### Add chart
helm repo add jetstack https://charts.jetstack.io
helm repo update
#### Certmanager Installation
```sh
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --set installCRDs=true
```
#### LetsEncrypt Issuer
```sh
kc create -f letsencrypt-production.yaml
```
apply ingress.yaml and restart ingress pod
Important -  Some times challenges are not created. use "kubectl rollout restart deployment -n cert-manager cert-manager".
