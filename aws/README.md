# AWS Infrastructure

Reusable Terraform configuration for a VPC, public/private subnets, Internet Gateway, NAT Gateway, security groups, and two Ubuntu 24.04 EC2 instances.

## Quick start

```bash
cp terraform.tfvars.example terraform.tfvars
```

Change at minimum:
- `aws_region`
- `allowed_ssh_cidr` — use your public IP as `x.x.x.x/32`
- `key_name` — an existing EC2 Key Pair in that region

Then:

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

Destroy when finished:

```bash
terraform destroy
```

## Architecture

```text
AWS
└── VPC
    ├── Public Subnet
    │   ├── Internet Gateway
    │   ├── NAT Gateway
    │   └── Public EC2
    │
    └── Private Subnet
        └── Private EC2
            └── Outbound traffic → NAT Gateway
```

The public EC2 allows SSH only from `allowed_ssh_cidr`. The private EC2 has no public IP and allows SSH only from the public EC2 security group.

The AMI defaults to the latest Ubuntu 24.04 LTS AMD64 image in the selected region.

No AWS credentials or private SSH keys are stored in this directory.
