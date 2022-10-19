provider "aws" {
  region                   = "ap-south-1"
  shared_config_files      = ["C:/Users/QA-010518-004/.aws/config"]
  shared_credentials_files = ["C:/Users/QA-010518-004/.aws/credentials"]
  profile                  = "default"
}

terraform {
  required_version = "~> 1.2.0"
  required_providers {
    aws = {
      version = "~> 4.21.0"
      source  = "hashicorp/aws"
    }

  }
  backend "s3" {
    bucket                  = "terraform-backend-store-traek-uat"
    encrypt                 = true
    key                     = "test/terraform.tfstate"
    region                  = "ap-south-1"
    shared_credentials_file = "C:/Users/QA-010518-004/.aws/credentials"
    profile                 = "default"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0c45bc91b9e6093d4"
  instance_type = "t3.small"
  key_name      = "jenkins"
  #   name            = "DockerInstanceCustomAMI"
  #   security_groups = aws_security_group.http.id
  vpc_security_group_ids = [aws_security_group.http.id]
  tags = {
    Name        = "Test-Packer"
    Environment = "dev"
  }
}


resource "aws_security_group" "http" {
  name        = "Allow HTTP and HTTPS"
  description = "Allow http&https inbound traffic"
  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "Test-Packer"
    Environment = "dev"
  }

}
