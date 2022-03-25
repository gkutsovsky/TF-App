provider "aws" {
  region  = "us-east-1"
}

### Import ELB from Module
module "web_app" {
  source = "./modules/web_app"

  web_image_id         = var.web_image_id
  web_instance_type    = var.web_instance_type
  web_desired_capacity = var.web_desired_capacity
  web_max_size         = var.web_max_size
  web_min_size         = var.web_min_size
  subnets              = [aws_default_subnet.default_az1.id,aws_default_subnet.default_az2.id]
  security_groups      = [aws_security_group.web_app.id]
  web_app	             = "web-app"
}
