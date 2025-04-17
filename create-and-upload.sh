#!/bin/bash

set -euo pipefail

# Variables
GITHUB_REPO="markusharder/k8s-deployment"  # Change this to your repo
SECRET_NAME="KUBECONFIG"
KUBECONFIG_PATH=$KUBECONFIG         # Adjust depending on how your Terraform setup outputs it

#  Step 1: Identify public IP
export TF_VAR_my_ip_cidr="$(curl -s https://api.ipify.org)/32"

# Step 1: Run terraform apply (auto-approve for scripting)
echo "Running terraform apply..."
terraform init
terraform apply -auto-approve

# Step 2: Get kubeconfig path
# If your terraform module outputs the kubeconfig content, use:
# terraform output -raw kubeconfig > "$KUBECONFIG_PATH"

# Or if your provider writes a kubeconfig file:
if [[ ! -f "$KUBECONFIG_PATH" ]]; then
    echo "ERROR: Kubeconfig file not found at $KUBECONFIG_PATH"
    exit 1
fi

# Step 3: Upload kubeconfig to GitHub secret
echo "Uploading kubeconfig to GitHub secret..."
gh secret set "$SECRET_NAME" -b"$(< "$KUBECONFIG_PATH")" -R "$GITHUB_REPO"

echo "Done: kubeconfig uploaded to GitHub secret '$SECRET_NAME' in repo '$GITHUB_REPO'"
