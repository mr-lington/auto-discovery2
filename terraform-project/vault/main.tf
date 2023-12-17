# Define the AWS provider block
provider "aws" {
  profile = var.profile
  region  = var.region
}

# Create an AWS key pair
resource "aws_key_pair" "vault-keypair" {
  key_name   = "vault-keypair"
  public_key = file(var.keypath)
}

# Create an AWS security group for Vault
resource "aws_security_group" "vault-sg" {
  name        = "vault-sg"
  description = "Allow Inbound Traffic"

  # Define ingress rules
  ingress {
    description = "HTTPS Port"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP Port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Vault Port"
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Define egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vault-sg"
  }
}

# Create an AWS KMS key for Vault
resource "aws_kms_key" "vault" {
  description             = "Vault Unseal Key"
  deletion_window_in_days = 10

  tags = {
    Name = "vault-server"
  }
}

# Import a Route53 Hosted Zone
data "aws_route53_zone" "zone_vault" {
  name         = var.domain-name
  private_zone = false
}

# Create a Route53 record for Vault
resource "aws_route53_record" "vault_record" {
  zone_id = data.aws_route53_zone.zone_vault.zone_id
  name    = var.domain-name
  type    = "A"
  records = [aws_instance.vault.public_ip]
  ttl     = 300
}

# Create an AWS instance for Terraform Vault
resource "aws_instance" "vault" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.vault-sg.id]
  iam_instance_profile        = aws_iam_instance_profile.vault-kms-unseal.id
  key_name                    = aws_key_pair.vault-keypair.key_name
  associate_public_ip_address = true


  user_data = templatefile("./vault-script.sh", {
    region               = var.region,
    kms_key              = aws_kms_key.vault.id,
    domain               = var.domain-name,
    email                = var.email,
    newrelic-id          = var.newrelic-id,
    newrelic-license-key = var.newrelic-license-key
  })

  tags = {
    Name = "vault-Server"
  }
}