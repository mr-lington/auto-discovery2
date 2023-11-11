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
  echo "pubkeyAcceptedkeyTypes=+ssh-rsa" >> /etc/ssh/sshd_config.d/10-insecure-rsa-keysig.conf
  systemctl reload sshd
  echo "${var.private-keypair}" >> /home/ec2-user/.ssh/id_rsa
  chown ec2-user /home/ec2-user/.ssh/id_rsa
  chgrp ec2-user /home/ec2-user/.ssh/id_rsa
  chmod 600 /home/ec2-user/.ssh/id_rsa
  sudo hostnamectl set-hostname Bastion
  EOF 
  tags = {
    Name = "bastion-server"
  }
}