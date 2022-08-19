helm upgrade apisix apisix/apisix -n ingress-apisix -f values.yaml
http://104.154.97.2:80


https://github.com/apache/apisix-ingress-controller/blob/master/docs/en/latest/practices/manage-certificates-with-cert-manager.md


### create issuer
kubectl apply -f ./tls/ca.yaml
kubectl apply -f ./tls/issuer.yaml



### test
kubectl -n ingress-apisix exec -it apisix-b4598fb9-j9mfz  -- curl --resolve 'local.httpbin.org:9443:127.0.0.1' "https://local.httpbin.org:9443/ip" -k


kubectl -n ingress-apisix exec -it apisix-b4598fb9-j9mfz  -- curl --resolve 'hasura.netinc.io:9443:127.0.0.1' "https://hasura.netinc.io:9443/ip" -k


kubectl -n ingress-apisix exec -it apisix-b4598fb9-j9mfz -- curl --resolve 'local.httpbin.org:9443:127.0.0.1' "https://local.httpbin.org:9443/ip" -k -v