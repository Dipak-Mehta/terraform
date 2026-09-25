output "vpc_id" {
  description = "ID of the created VPC."
  value       = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "ID of the public subnet."
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the private subnet."
  value       = aws_subnet.private.id
}

output "nat_gateway_public_ip" {
  description = "Elastic IP attached to the NAT Gateway."
  value       = aws_eip.nat.public_ip
}

output "public_instance_id" {
  description = "ID of the public EC2 instance."
  value       = aws_instance.public.id
}

output "public_instance_public_ip" {
  description = "Public IPv4 address of the public EC2 instance."
  value       = aws_instance.public.public_ip
}

output "public_instance_private_ip" {
  description = "Private IPv4 address of the public EC2 instance."
  value       = aws_instance.public.private_ip
}

output "private_instance_id" {
  description = "ID of the private EC2 instance."
  value       = aws_instance.private.id
}

output "private_instance_private_ip" {
  description = "Private IPv4 address of the private EC2 instance."
  value       = aws_instance.private.private_ip
}
