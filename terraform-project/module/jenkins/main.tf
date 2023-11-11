resource "aws_instance" "jenkins-server" {
  ami                               = var.ami
  instance_type                     = var.instance-type
  key_name                          = var.keypair
  vpc_security_group_ids            = [var.jenkins-SG]
  subnet_id                         = var.subnet-id
  user_data                         = local.jenkins_user_data
  tags = {
    Name = "jenkins-server"
  }
}