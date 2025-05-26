apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - github.com/minio/operator?ref=v7.1.1
  - namespace.yaml
  - storage-config.yaml
  - storage-user.dec.yaml
  - tenant.yaml
  - ingress.yaml
