# AWS Infrastructure with Terraform

A reusable Terraform project that creates a complete AWS network foundation with **one public EC2 instance and one private EC2 instance**.

The goal is simple: **clone the repository, change the values in `terraform.tfvars`, and deploy the same infrastructure without editing the Terraform resource code.**

## What this creates

```text
AWS
└── VPC (10.0.0.0/16)
    ├── Internet Gateway
    │
    ├── Public Subnet (10.0.1.0/24)
    │   ├── Public Route Table → Internet Gateway
    │   ├── NAT Gateway + Elastic IP
    │   └── Public EC2
    │       └── SSH from your allowed CIDR
    │
    └── Private Subnet (10.0.2.0/24)
        ├── Private Route Table → NAT Gateway
        └── Private EC2
            └── SSH only from Public EC2
```

### Resources

- VPC
- Public subnet
- Private subnet
- Internet Gateway
- Public and private route tables
- NAT Gateway
- Elastic IP for NAT Gateway
- Public security group
- Private security group
- Public EC2 instance
- Private EC2 instance
- Terraform outputs for important resource IDs and IPs

## Prerequisites

Install:

- Terraform >= 1.6
- AWS CLI
- An AWS account
- An existing EC2 Key Pair in the target AWS region

Configure AWS credentials using the AWS CLI or another supported AWS credential mechanism. **Do not put AWS access keys or secret keys in Terraform files.**

Example:

```bash
aws configure
aws sts get-caller-identity
```

## Quick start

### 1. Clone

```bash
git clone https://github.com/Dipak-Mehta/terraform.git
cd terraform
```

### 2. Create your variables file

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit only `terraform.tfvars`.

At minimum, change:

```hcl
allowed_ssh_cidr = "YOUR_PUBLIC_IP/32"
key_name         = "YOUR_EXISTING_KEYPAIR_NAME"
```

You can also change the region, CIDRs, instance type, names, and other values.

### 3. Initialize

```bash
terraform init
```

### 4. Format and validate

```bash
terraform fmt -recursive
terraform validate
```

### 5. Review the plan

```bash
terraform plan
```

### 6. Create the infrastructure

```bash
terraform apply
```

Type `yes` when prompted.

### 7. Get connection information

```bash
terraform output
```

The public EC2 address is available with:

```bash
terraform output -raw public_instance_public_ip
```

## SSH flow

The public instance is reachable from the CIDR configured in `allowed_ssh_cidr`.

The private instance is **not directly exposed to the internet**. Its security group allows SSH only from the public instance's security group.

Typical flow:

```text
Your Laptop
    |
    | SSH
    v
Public EC2
    |
    | SSH over private VPC network
    v
Private EC2
```

The private subnet uses the NAT Gateway for outbound internet access when required.

## Important security notes

- Never commit `terraform.tfvars`, AWS credentials, private keys, or Terraform state files.
- Restrict `allowed_ssh_cidr` to your public IP, preferably as `x.x.x.x/32`.
- This project intentionally does not create or store an SSH private key.
- NAT Gateway and EC2 resources can incur AWS charges. Review the plan and AWS pricing before applying.
- The default Ubuntu AMI lookup selects the latest Ubuntu 24.04 LTS AMD64 image available in the selected region. Set `ami_id` if you need a specific AMI.

## Customization

Most users only need to edit:

| Variable | Purpose |
|---|---|
| `aws_region` | AWS region |
| `project_name` | Resource naming prefix |
| `vpc_cidr` | VPC network range |
| `public_subnet_cidr` | Public subnet range |
| `private_subnet_cidr` | Private subnet range |
| `availability_zone` | Availability Zone |
| `allowed_ssh_cidr` | Public EC2 SSH source |
| `key_name` | Existing EC2 Key Pair |
| `ami_id` | Optional custom AMI |
| `instance_type` | EC2 size |
| `public_instance_name` | Public EC2 name |
| `private_instance_name` | Private EC2 name |

No resource files need to be edited for normal deployments.

## Destroy

When you are finished:

```bash
terraform destroy
```

Review the destroy plan carefully before confirming.

## Project structure

```text
.
├── provider.tf
├── variables.tf
├── vpc.tf
├── nat.tf
├── ec2.tf
├── outputs.tf
├── terraform.tfvars.example
├── .gitignore
└── README.md
```

## Notes for contributors

The resource architecture is intentionally kept simple so it is easy to understand and reuse. If you extend it, keep environment-specific values in variables rather than hard-coding them into resources.

---

Built as a reusable AWS Terraform reference project by Dipak Mehta.
