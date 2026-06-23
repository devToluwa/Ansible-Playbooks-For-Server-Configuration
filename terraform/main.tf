provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "ansible_sg" {
  name        = "ansible_sg"
  description = "Security group for Ansible project EC2 instances"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/24"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/24"]
  }
}

resource "aws_instance" "webservers" {
  count                  = 2
  ami                    = var.ami.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ansible_sg.id]

  tags = {
    Name = "webserver-${count.index + 1}"
  }
}

resource "aws_instance" "dbserver" {
  ami                    = 2
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ansible_sg.id]

  tags = {
    Name = "dbserver"
  }
}
