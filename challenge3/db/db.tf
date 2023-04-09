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