# Create keypair with Terraform
resource "tls_private_key" "Keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "Keypair_priv" {
  filename        = "lington_key.pem"
  content         = tls_private_key.Keypair.private_key_pem
  file_permission = "600"
}

resource "aws_key_pair" "Keypair_pub" {
  key_name   = "lington_key"
  public_key = tls_private_key.Keypair.public_key_openssh
}