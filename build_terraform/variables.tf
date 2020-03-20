variable "instance_type" {
  default     = "t3.xlarge"
}

variable "associate_public_ip_address" {
  default     = false
}

variable "server_name" {
  default = "admin"
}

variable "env" {
  description = "The environment name, i.e. prod"
  default     = "dev"
}

variable "aws_key_pair" {
   default = "keypair-bastion-infra"
}

variable "vpc-name" { 
  default = ""
}

variable "myip" {
  default = ""
}


variable "vpc-id" {
  default = "vpc-92c61eeb"
}

variable "ami" { 
  default = "ami-id" 
}

variable "aws_region" { 
  default = "us-east-1" 
}

variable "subnet" { 
  default = "subnet-29c51b73" 
}

variable "availability_zones" {
  description = "AWS availability zones."
  default     = ["us-east-1d"]
}

