# creating Bastian Host 
resource "aws_instance" "bastion" {
  ami                       = var.ami
  vpc_security_group_ids    = [var.bastion-SG]
  instance_type             = var.instance-type
  key_name                  = var.keypair
  subnet_id                 = var.subnet-id
  associate_public_ip_address = true
  user_data                 = <<-EOF
  #!/bin/bash
  sudo hostnamectl set-hostname Bastion
  EOF

  tags = {
    Name = "bastion-server"
  }
}