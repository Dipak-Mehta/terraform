variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "region" {
  description = "GCP region."
  type        = string
  default     = "asia-south1"
}

variable "zone" {
  description = "GCP zone."
  type        = string
  default     = "asia-south1-a"
}

variable "project_name" {
  description = "Prefix used for resource names."
  type        = string
  default     = "terraform-gcp-infra"
}

variable "network_cidr" {
  description = "CIDR for the custom VPC subnet."
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet."
  type        = string
  default     = "10.20.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet."
  type        = string
  default     = "10.20.2.0/24"
}

variable "allowed_ssh_cidr" {
  description = "Public IP/CIDR allowed to SSH to the public VM."
  type        = string
}

variable "machine_type" {
  description = "GCE machine type for both VMs."
  type        = string
  default     = "e2-micro"
}

variable "image_project" {
  description = "GCP image project."
  type        = string
  default     = "ubuntu-os-cloud"
}

variable "image_family" {
  description = "GCP image family."
  type        = string
  default     = "ubuntu-2404-lts-amd64"
}

variable "ssh_username" {
  description = "Linux SSH username."
  type        = string
  default     = "gcpadmin"
}

variable "ssh_public_key" {
  description = "SSH public key in 'username:ssh-rsa/ed25519...' format."
  type        = string
  sensitive   = true
}
