variable "aws_region" {
  description = "AWS region where all resources will be created."
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name prefix used for AWS resources and tags."
  type        = string
  default     = "terraform-aws-infra"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet."
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "Availability Zone used by both subnets."
  type        = string
  default     = "ap-south-1a"
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to SSH to the public EC2 instance. Use your-public-ip/32."
  type        = string
}

variable "key_name" {
  description = "Name of an existing EC2 Key Pair in the selected AWS region."
  type        = string
}

variable "ami_id" {
  description = "Optional AMI ID. Leave empty to automatically use the latest Ubuntu 24.04 LTS AMD64 AMI."
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type for both instances."
  type        = string
  default     = "t3.micro"
}

variable "public_instance_name" {
  description = "Name tag for the public EC2 instance."
  type        = string
  default     = "public-instance"
}

variable "private_instance_name" {
  description = "Name tag for the private EC2 instance."
  type        = string
  default     = "private-instance"
}
