For example policies that you can enforce with OPA see https://www.openpolicyagent.org.

If you installed this chart with the default values, you can exercise the sample policy.

# 1. Create a namespace called "opa-example"

kubectl create namespace opa-example

# 2. Create an Ingress in the "opa-example" namespace that complies with the policy.

cat > ingress-ok.yaml <<EOF
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ingress-ok
spec:
  rules:
  - host: signin.dev.acmecorp.com
    http:
      paths:
      - backend:
          serviceName: nginx
          servicePort: 80
EOF

kubectl -n opa-example create -f ingress-ok.yaml

# 3. Try to create an Ingress in the "opa-example" namespace that violates the policy.

cat > ingress-bad.yaml <<EOF
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ingress-bad
spec:
  rules:
  - host: signin.acmecorp.com
    http:
      paths:
      - backend:
          serviceName: nginx
          servicePort: 80
EOF

kubectl -n opa-example create -f ingress-bad.yaml

If you want to turn off authz for debugging purposes, you can do so by upgrading the chart like so:
helm upgrade opa stable/opa --reuse-values --set authz.enabled=false

You can query OPA to see the policies it has loaded (you will need to turn off authz as described above):

export OPA_POD_NAME=$(kubectl get pods --namespace opa -l "app=opa-opa-kube-mgmt" -o jsonpath="{.items[0].metadata.name}")

kubectl port-forward $OPA_POD_NAME 8080:443 --namespace opa

curl -k -s https://localhost:8080/v1/policies | jq -r '.result[].raw'