resource "aws_instance" "sonarqube" {
  ami           = var.ami
  instance_type = var.instance-type
  subnet_id = var.subnet-id
  key_name = var.keypair
  vpc_security_group_ids = [var.sonarqube-sg]
  associate_public_ip_address = true
  user_data = local.sonarqube_user_data

  tags = {
    Name = "sonarqube"
  }
}