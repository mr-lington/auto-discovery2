output "sonarqube-ip" { 
    value = aws_instance.sonarqube.public_ip
}