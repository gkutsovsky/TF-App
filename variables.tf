variable "whitelist" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "web_image_id" {
  type    = string
  default = "ami-03c8adc67e56c7f1d"
}
variable "web_instance_type" {
  type    = string
  default = "t2.micro"
}
variable "web_desired_capacity" {
  type    = number
  default = 1 
}
variable "web_max_size" {
  type    = number
  default = 1
}
variable "web_min_size" {
  type    = number
  default = 1
}


