resource "aws_instance" "web" {
  ami           = "ami-09ee0944866c73f62"
  instance_type = "t2.micro"

  tags = {
    Name = "web"
  }
  vpc_security_group_ids = [aws_security_group.challenge_web_sg.id]
  user_data = file ("./web/test_script.sh")

}

output "instance_id" {
  description = "Private IP address of the db server"
  value       = aws_eip.web.public_ip
  


module "eip" {
    source = "../eip"
    
}

module "sg" {
    source = "../sg"
    
}



