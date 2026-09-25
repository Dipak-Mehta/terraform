# GCP Infrastructure

Reusable Terraform configuration for a custom VPC, public/private subnets, Cloud Router + Cloud NAT, firewall rules, and two Ubuntu 24.04 Compute Engine VMs.

## Quick start

1. Install Terraform >= 1.6 and Google Cloud CLI.
2. Authenticate:

```bash
gcloud auth application-default login
gcloud config set project YOUR_GCP_PROJECT_ID
```

3. Configure variables:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Change `project_id`, `allowed_ssh_cidr`, and `ssh_public_key`. Adjust region, zone, CIDRs, or machine type if needed.

4. Enable required APIs:

```bash
gcloud services enable compute.googleapis.com
```

5. Deploy:

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

6. Destroy when finished:

```bash
terraform destroy
```

## Architecture

The public VM receives an ephemeral public IP and allows SSH only from `allowed_ssh_cidr`. The private VM has no external IP and allows SSH only from the public VM. Cloud NAT provides outbound internet access for the private subnet.

No service-account keys or private SSH keys are stored in this repository.
