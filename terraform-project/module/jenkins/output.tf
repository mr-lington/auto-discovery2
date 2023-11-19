output "jenkins-ip" {
  value = aws_instance.jenkins-server.private_ip
}

output "jenkins-id" {
  value = aws_instance.jenkins-server.id
}

# output "jenkins-dns" {
#   value = aws_elb.lb.dns_name
# }