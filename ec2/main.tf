provider "aws" {
  region  = "eu-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-09ee0944866c73f62"
  instance_type = "t2.micro"
  count = "3"

  tags = {
    Name = element(var.ec2_name,count.index)
  }

}


variable "ec2_name" {
  type = list
  default = [ "app","db","web" ]
}