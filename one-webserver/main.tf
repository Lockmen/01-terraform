terraform {
  # 테라폼 버전 지정 
  required_version = ">= 1.0.0, < 2.0.0"

  # 공급자 버전 지정
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "aws02_example" {
  ami                    = "ami-06eea3cd85e2db8ce"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name = "aws02-key"

  user_data = <<-EOF
				#!/bin/bash
				echo "Hello, World" > index.html
				nohup busybox httpd -f -p 8080 &
				EOF


  tags = {
    Name = "aws02-terraform-example"
  }

}


# 보안그룹 설정 8080포트 Open
resource "aws_security_group" "instance" {
  name = "aws02-terraform-example-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

}



# Public IP Output
output "public-ip" {
  value       = aws_instance.aws02_example.public_ip
  description = "The public IP of the Instance"
}












