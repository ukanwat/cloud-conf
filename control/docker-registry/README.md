  export POD_NAME=$(kubectl get pods --namespace docker-registry -l "app=docker-registry,release=docker-registry" -o jsonpath="{.items[0].metadata.name}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl -n docker-registry port-forward $POD_NAME 8080:5000