resource "aws_eip" "web" {
  instance = aws_instance.web.id
  vpc      = true
}

variable "ingress" {
  type = list (number)
  default =[80, 443]
}

variable "egress" {
  type = list (number)
  default = [80, 443]
}

output "instance_eip" {
  description = "Private IP address of the db server"
  value       = aws_eip.web.public_ip
  
}