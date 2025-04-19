#create security group 

resource "aws_security_group" "mysg" {
  name        = "My-SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "mysg"
  }
}

resource "aws_security_group" "mysgforprivateEC2" {
  name        = "My-SGPVT"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.public-instance.private_ip}/32"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "mysgforprivateEC2"
  }
}

# output "public-ip" {
#   value = aws_security_group.mysg_id

# }

# create instance public instance

resource "aws_instance" "public-instance" {
  ami                         = "ami-06489866022e12a14"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public-subnet.id
  security_groups             = ["${aws_security_group.mysg.id}"]
  key_name                    = "task"
  associate_public_ip_address = true
  tags = {
    Name = "public-instance"
  }
}

# create instance private intance

resource "aws_instance" "private-instance" {
  ami                         = "ami-01216e7612243e0ef"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.private-subnet.id
  security_groups             = ["${aws_security_group.mysg.id}"]
  key_name                    = "task"
  associate_public_ip_address = false
  tags = {
    Name = "private-instance"
  }
}
