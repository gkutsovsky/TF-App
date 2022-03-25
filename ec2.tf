resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16" # Base CIDR Block
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "us-east-1a"
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = "us-east-1b"
}

resource "aws_security_group" "web_app" {
  name        = "web-app"
  description = "Allow standard http and https ports inbound and everything outbound"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.whitelist
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.whitelist
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "public-ec2" {
    ami           = var.web_image_id
    instance_type = var.web_instance_type

    key_name      = "web-app-key-pair"
    vpc_security_group_ids = [ aws_security_group.web_app.id ]
    associate_public_ip_address = true

    tags = {
        Name = "ec2-main"
    }
    user_data = <<EOF
#!/bin/sh
sudo apt-get update
sudo apt-get install -y mysql-client
EOF
}

