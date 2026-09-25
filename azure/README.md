# Azure Infrastructure

Reusable Terraform configuration for an Azure resource group, VNet, public/private subnets, NAT Gateway, NSGs, and two Ubuntu 24.04 Linux VMs.

## Quick start

1. Install Terraform >= 1.6 and Azure CLI.
2. Authenticate:

```bash
az login
az account set --subscription YOUR_AZURE_SUBSCRIPTION_ID
```

3. Configure variables:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Change `subscription_id`, `allowed_ssh_cidr`, and `ssh_public_key`. Adjust location, CIDRs, VM size, or names if needed.

4. Deploy:

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

5. Destroy when finished:

```bash
terraform destroy
```

## Architecture

Public VM has a static public IP and SSH is restricted to `allowed_ssh_cidr`. Private VM has no public IP and accepts SSH only from the public subnet. The private subnet uses Azure NAT Gateway for outbound internet access.

No Azure credentials or private keys are stored in this repository.
