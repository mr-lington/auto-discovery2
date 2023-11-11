output "out-pub-key" {
  value = aws_key_pair.Keypair_pub.key_name
}

output "out-priv-key" {
  value = tls_private_key.Keypair.private_key_pem
}