#!/bin/bash

set -euo pipefail

#  Step 1: Identify public IP
export TF_VAR_my_ip_cidr="$(curl -s https://api.ipify.org)/32"

# Step 1: Run terraform apply (auto-approve for scripting)
echo "Running terraform destroy..."
terraform destroy


