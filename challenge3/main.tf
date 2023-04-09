provider "aws" {
  region  = "eu-west-2"
}

module "db" {
  source = "./db"
  
}

module "web" {
  source = "./web"
  
}


output "instance_private_ip" {
  description = "Private IP address of the db server"
  value       = module.db.instance_private_ip
  
} 



output "instance_eip" {
  description = "Private IP address of the db server"
  value       = aws_eip.web.public_ip
  
} 

