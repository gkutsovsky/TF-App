resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  db_name              = "rds-db"
  username             = "foo"
  password             = random_password.password.result
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
### Generate random password from Terraform 
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
### Save the password in paramter store
resource "aws_ssm_parameter" "db-pw" {
  name  = "db-pw"
  type  = "String"
  value = random_password.password.result
}
### Security Group that allows into RDS DB
resource "aws_security_group" "rds-sg" {
  name        = "rds-security-group"
  description = "allow inbound access to the database"
  vpc_id      = aws_vpc.main

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 3306
    cidr_blocks = var.whitelist
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = var.whitelist
  }
}
resource "aws_db_parameter_group" "default" {
  name   = "rds-pg"
  family = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}