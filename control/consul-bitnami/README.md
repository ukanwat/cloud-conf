In order to access to the Consul Web UI:

1. Get the Consul URL by running these commands:

    kubectl port-forward --namespace consul svc/consul-ui :
    echo "Consul URL: http://127.0.0.1:"

2. Access ASP.NET Core using the obtained URL.

Please take into account that you need to wait until a cluster leader is elected before using the Consul Web UI.

In order to check the status of the cluster you can run the following command:

    kubectl exec -it consul-0 -- consul members

Furthermore, to know which Consul node is the cluster leader run this other command:

    kubectl exec -it consul-0 -- consul operator raft list-peers