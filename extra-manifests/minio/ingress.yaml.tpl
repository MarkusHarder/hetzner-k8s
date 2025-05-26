apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: minio
  namespace: minio-tenant
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt
    traefik.ingress.kubernetes.io/router.entrypoints: websecure
    traefik.ingress.kubernetes.io/router.middlewares: int-snaptrail-add-ui@kubernetescrd
spec:
  ingressClassName: traefik
  tls:
  - hosts:
    - minio.markusharder.com
    secretName: minio-tls
  rules:
  - host: minio.markusharder.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: minio
            port:
              number: 80

