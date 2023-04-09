provider "aws" {
  region  = "eu-west-2"
}

resource "aws_instance" "db" {
  ami           = "ami-09ee0944866c73f62"
  instance_type = "t2.micro"

  tags = {
    Name = "db"
  }

}



output "instance_private_ip" {
  description = "Private IP address of the db server"
  value       = aws_instance.db.private_ip
  
} 

resource "aws_instance" "web" {
  ami           = "ami-09ee0944866c73f62"
  instance_type = "t2.micro"

  tags = {
    Name = "web"
  }
  vpc_security_group_ids = [aws_security_group.challenge_web_sg.id]
  user_data = file ("test_script.sh")

}

resource "aws_eip" "web" {
  instance = aws_instance.web.id
  vpc      = true
}

output "instance_eip" {
  description = "Private IP address of the db server"
  value       = aws_eip.web.public_ip
  
} 

variable "ingress" {
  type = list (number)
  default =[80, 443]
}

variable "egress" {
  type = list (number)
  default = [80, 443]
}

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