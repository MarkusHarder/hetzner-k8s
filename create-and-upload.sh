#!/bin/bash

set -euo pipefail

# Variables
GITHUB_REPO=("markusharder/k8s-deployment" "markusharder/snaptrail")  
SECRET_NAME="KUBECONFIG"
KUBECONFIG_PATH=$KUBECONFIG         

export TF_VAR_my_ip_cidr="$(curl -s https://api.ipify.org)/32"

echo "Running terraform apply..."
terraform init
terraform apply -auto-approve

if [[ ! -f "$KUBECONFIG_PATH" ]]; then
    echo "ERROR: Kubeconfig file not found at $KUBECONFIG_PATH"
    exit 1
fi

# Step 3: Upload kubeconfig to GitHub secret
echo "Uploading kubeconfig to GitHub secret..."
for repo in "${GITHUB_REPO[@]}"; do
    gh secret set "$SECRET_NAME" -b"$(< "$KUBECONFIG_PATH")" -R "$repo"
done

echo "Done: kubeconfig uploaded to GitHub secret '$SECRET_NAME' in repo '$GITHUB_REPO'"
