apiVersion: v1
kind: Secret
metadata:
  name: storage-configuration
  namespace: minio-tenant
stringData:
  config.env: |-
    export MINIO_ROOT_USER="minio"
    export MINIO_ROOT_PASSWORD="some-password"
    export MINIO_STORAGE_CLASS_STANDARD="EC:2"
    export MINIO_BROWSER="on"
    export CONSOLE_TLS_ENABLE="off"
type: Opaque
