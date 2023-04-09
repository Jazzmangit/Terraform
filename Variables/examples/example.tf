variable "inputname" {
    type        = string
    description ="set value name of the VPC"
  }

resource "aws_vpc" "jeromevpc" {
    cidr_block = "10.10.0.0/20"
  tags = {
    Name = var.inputname
  }
}

variable "sshport" {
  type = number
  default = 22
}

variable "enable_classiclink_dns_support" {
  default = true
}

variable "mylist" {
  type = list(string)
  default = [ "value1","value2" ]
}

 # tags = {
 #   Name = element(var.ec2_name, count.index)
 # }


variable "ec2_name" {
  type = list
  default = [ "app","db","web" ]
}

variable "mymap" {
  type = map
  default = {
    key1 = "value1"
    key2 = "value2"
  }
}

output "vpcid" {
  value = aws_vpc.jeromevpc.id
}