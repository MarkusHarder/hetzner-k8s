apiVersion: minio.min.io/v2
kind: Tenant
metadata:
  name: myminio
  namespace: minio-tenant
spec:
  requestAutoCert: false
  configuration:
    name: storage-configuration
  image: quay.io/minio/minio:RELEASE.2024-10-02T17-50-41Z
  mountPath: /export
  pools:
    - name: pool-0
      servers: 2
      volumesPerServer: 2
      volumeClaimTemplate:
        spec:
          accessModes:
            - ReadWriteOnce
          resources:
            requests:
              storage: 20Gi
          storageClassName: longhorn
  users:
    - name: storage-user
