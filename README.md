# Multi-Cloud Infrastructure with Terraform

Reusable Terraform infrastructure templates for **AWS, Azure, and GCP**.

The repository is organized by cloud provider. Each directory is a **self-contained Terraform project** with its own provider, variables, networking, compute, security, outputs, example variables, and README.

The intended workflow is:

> **Choose a cloud → copy `terraform.tfvars.example` → change your values → run Terraform.**

You should not need to edit the infrastructure/resource files for a normal deployment.

## Repository structure

```text
terraform/
├── aws/
│   ├── provider.tf
│   ├── variables.tf
│   ├── vpc.tf
│   ├── nat.tf
│   ├── ec2.tf
│   ├── outputs.tf
│   ├── terraform.tfvars.example
│   ├── .gitignore
│   └── README.md
│
├── azure/
│   ├── provider.tf
│   ├── variables.tf
│   ├── network.tf
│   ├── security.tf
│   ├── compute.tf
│   ├── outputs.tf
│   ├── terraform.tfvars.example
│   ├── .gitignore
│   └── README.md
│
└── gcp/
    ├── provider.tf
    ├── variables.tf
    ├── network.tf
    ├── security.tf
    ├── compute.tf
    ├── outputs.tf
    ├── terraform.tfvars.example
    ├── .gitignore
    └── README.md
```

## What each cloud creates

| Cloud | Network | Public VM | Private VM | NAT |
|---|---|---|---|---|
| AWS | VPC + public/private subnets | EC2 | EC2 | NAT Gateway |
| Azure | VNet + public/private subnets | Linux VM | Linux VM | NAT Gateway |
| GCP | Custom VPC + public/private subnets | Compute Engine | Compute Engine | Cloud NAT |

The architecture is intentionally similar across providers so the same networking concepts are easy to understand and compare.

## AWS

```bash
cd aws
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars

terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

Creates a VPC, public/private subnets, Internet Gateway, NAT Gateway, route tables, security groups, and two EC2 instances.

## Azure

```bash
cd azure
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars

az login
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

Creates a resource group, VNet, public/private subnets, NAT Gateway, NSGs, and two Ubuntu Linux VMs.

## GCP

```bash
cd gcp
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars

gcloud auth application-default login
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

Creates a custom VPC, public/private subnets, Cloud Router, Cloud NAT, firewall rules, and two Ubuntu Compute Engine VMs.

## What you normally change

Each cloud has its own `terraform.tfvars.example`.

Typical values to change:

- Cloud region / zone
- Project or subscription ID
- VPC/VNet CIDRs
- Public/private subnet CIDRs
- Your public IP for SSH
- Existing SSH key / public key
- VM instance size
- Resource naming

Example:

```hcl
allowed_ssh_cidr = "YOUR_PUBLIC_IP/32"
```

This keeps SSH access restricted instead of exposing port 22 to the entire internet.

## Authentication

This repository does **not** contain cloud credentials.

Use the standard CLI/credential mechanism for each provider:

- AWS: AWS CLI credentials, IAM role, or environment variables
- Azure: Azure CLI / managed identity / supported environment variables
- GCP: Application Default Credentials, workload identity, or supported environment variables

Never put access keys, service-account JSON files, passwords, or private SSH keys into this repository.

## Cost warning

These configurations create real cloud resources and can incur charges, especially:

- AWS NAT Gateway
- Azure NAT Gateway
- GCP Cloud NAT
- EC2 / Azure VM / GCE instances
- Public IP addresses

Always review `terraform plan` and your cloud provider pricing before applying.

## Destroy infrastructure

Each cloud directory has its own Terraform state.

```bash
terraform destroy
```

Run this from the cloud directory you deployed.

## Design goal

This repository is designed as a **simple, reusable multi-cloud Terraform reference**:

```text
                 Terraform
                     |
        ┌────────────┼────────────┐
        │            │            │
       AWS         Azure          GCP
        │            │            │
       VPC          VNet       Custom VPC
        │            │            │
   Public/Private Public/Private Public/Private
        │            │            │
     EC2 x2       VM x2         GCE x2
        │            │            │
       NAT          NAT         Cloud NAT
```

For normal use, change variables rather than resource code.

## Validation

GitHub Actions validates Terraform formatting and configuration for the cloud projects on every push and pull request.

---

Built as a reusable multi-cloud Terraform reference by Dipak Mehta.
