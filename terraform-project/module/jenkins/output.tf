output "jenkins-ip" {
  value = aws_instance.jenkins-server.private_ip
}

output "jenkins-id" {
  value = aws_instance.jenkins-server.id
}