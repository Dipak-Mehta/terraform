variable "subscription_id" {
  description = "Azure subscription ID. Can also be supplied through Azure CLI environment/context."
  type        = string
  default     = ""
}

variable "tenant_id" {
  description = "Azure tenant ID. Optional when already configured through Azure CLI."
  type        = string
  default     = ""
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "Central India"
}

variable "project_name" {
  description = "Prefix used for Azure resource names."
  type        = string
  default     = "terraform-azure-infra"
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
  default     = "terraform-azure-rg"
}

variable "vnet_cidr" {
  description = "Virtual network CIDR."
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR."
  type        = string
  default     = "10.10.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Private subnet CIDR."
  type        = string
  default     = "10.10.2.0/24"
}

variable "admin_source_cidr" {
  description = "Public IP/CIDR allowed to SSH to the public VM."
  type        = string
}

variable "admin_username" {
  description = "Linux administrator username."
  type        = string
  default     = "azureadmin"
}

variable "ssh_public_key" {
  description = "SSH public key content."
  type        = string
  sensitive   = true
}

variable "vm_size" {
  description = "Azure VM size."
  type        = string
  default     = "Standard_B2s"
}

variable "ubuntu_offer" {
  description = "Ubuntu marketplace offer."
  type        = string
  default     = "ubuntu-24_04-lts"
}

variable "ubuntu_sku" {
  description = "Ubuntu marketplace SKU."
  type        = string
  default     = "server"
}

variable "ubuntu_version" {
  description = "Ubuntu marketplace version."
  type        = string
  default     = "latest"
}
