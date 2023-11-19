resource "aws_instance" "ansible-server" {
  ami                               = var.ami
  instance_type                     = var.instance-type
  key_name                          = var.keypair
  vpc_security_group_ids            = [var.ansible-SG]
  subnet_id                         = var.subnet-id
  user_data                         = local.ansible_user_data
  tags = {
    Name = "ansible-server"
  }
}