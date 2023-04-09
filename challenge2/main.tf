provider "aws" {
  region  = "eu-west-2"
}

resource "aws_instance" "servers" {
  ami           = "ami-09ee0944866c73f62"
  instance_type = "t2.micro"

  tags = {
    Name = "db"
  }

}


output "instance_private_ip" {
  description = "Private IP address of the db server"
  value       = aws_instance.servers.private_ip
  
} 

resource "aws_instance" "web" {
  ami           = "ami-09ee0944866c73f62"
  instance_type = "t2.micro"

  tags = {
    Name = "web"
  }
  vpc_security_group_ids = [aws_security_group.challenge_web_sg.id]

}

resource "aws_eip" "web" {
  instance = aws_instance.web.id
  vpc      = true
}

output "instance_eip" {
  description = "Private IP address of the db server"
  value       = aws_eip.web.public_ip
  
} 

resource "aws_security_group" "challenge_web_sg" {

  name        = "challenge_web_sg"

  description = "Allow TLS inbound traffic"
  #vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "challenge_web_sg"

    
  }
}