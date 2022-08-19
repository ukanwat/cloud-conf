https://deepsource.io/blog/setup-vault-kubernetes/

utkarshk
a1KZodh9aXhpNfQpQHonXjCdYCTg6P5T

vault write auth/kubernetes/config \
        token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
        kubernetes_host="https://104.198.203.115:443" \
        kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt


vault policy write internal-app - <<EOH
path "internal/data/coplane/config" {
  capabilities = ["read"]
}
EOH