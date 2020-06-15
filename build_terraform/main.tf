
provider "aws" {
  region     = var.aws_region
}

data "aws_vpc" "default" {
  state = "available"
  id = "${var.vpc-id}"
}


data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.default.id}"
}

resource "aws_security_group" "bastion" {
  tags = {
    Name = "${var.server_name}"
  }
  vpc_id = data.aws_vpc.default.id
  name   = "${var.env}-${var.server_name}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.myip}"] 
  }
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["${var.myip}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}


resource "aws_instance" "bastion" {
  key_name      = var.aws_key_pair
  ami           = var.ami
  instance_type = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  availability_zone      = var.availability_zones[0]
  subnet_id = var.subnet
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
  ebs_block_device  {
    device_name = "/dev/sdb"
    volume_size = "30"
    volume_type = "standard"
  }
  tags = {
    Name = "${var.env}-${var.server_name}"
  }

}

output "server_ip" {
       value="${var.associate_public_ip_address ?  aws_instance.bastion.public_ip: aws_instance.bastion.private_ip}"
}
