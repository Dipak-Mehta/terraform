data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

locals {
  effective_ami_id = var.ami_id != "" ? var.ami_id : data.aws_ami.ubuntu.id
}

resource "aws_security_group" "public" {
  name        = "${var.project_name}-public-sg"
  description = "SSH access to the public EC2 instance"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "SSH from the configured administrator CIDR"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-public-sg"
    Project = var.project_name
  }
}

resource "aws_security_group" "private" {
  name        = "${var.project_name}-private-sg"
  description = "SSH access to the private EC2 instance from the public EC2 instance"
  vpc_id      = aws_vpc.this.id

  ingress {
    description     = "SSH from public EC2 instance"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
  }

  egress {
    description = "Allow outbound traffic through the NAT Gateway"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-private-sg"
    Project = var.project_name
  }
}

resource "aws_instance" "public" {
  ami                         = local.effective_ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids     = [aws_security_group.public.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name    = var.public_instance_name
    Project = var.project_name
    Tier    = "public"
  }
}

resource "aws_instance" "private" {
  ami                         = local.effective_ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids     = [aws_security_group.private.id]
  key_name                    = var.key_name
  associate_public_ip_address = false

  tags = {
    Name    = var.private_instance_name
    Project = var.project_name
    Tier    = "private"
  }
}
