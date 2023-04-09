resource "aws_security_group" "challenge_web_sg" {

  name        = "challenge_web_sg"

  description = "Allow TLS inbound traffic"
  #vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress
    content {
      description      = "TLS from VPC"
      from_port        = port.value
      to_port          = port.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress
    content {
      description      = "TLS from VPC"
      from_port        = port.value
      to_port          = port.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  

  tags = {
    Name = "challenge_web_sg"

    
  }
}