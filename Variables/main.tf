variable "inputvpc" {
    type = string
    description = "Set the name of the VPC"
}

provider "aws" {
    region = "eu-west-2"
}
resource "aws_vpc" "myvpc" {
    cidr_block = "10.10.0.0/16"
    tags = {
        Name = var.inputvpc
    }
}

output "vpcid" {
    value = aws_vpc.myvpc.id
}

