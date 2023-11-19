# creating nexus server 
resource "aws_instance" "nexus-server" {
  ami                         = var.ami
  instance_type        = var.instance-type
  key_name                 = var.keypair
  vpc_security_group_ids      = [var.nexus-SG]
  subnet_id                   = var.subnet-id
  associate_public_ip_address = true
  user_data                   = local.nexus-user-data
  tags = {
   Name = "nexus-server"
  }
}