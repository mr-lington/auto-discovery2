# out the vpc ID
output "vpc-id" {
  value = aws_vpc.vpc.id
}

output "prvsub1" {
    value = aws_subnet.prv-sn-01.id
}

output "prvsub2" {
    value = aws_subnet.prv-sn-02.id
}

output "pubsub1" {
  value = aws_subnet.pub-sn-01.id
}

output "pubsub2" {
  value = aws_subnet.pub-sn-02.id
}

output "pubsubs1-2-id" {
  value = [aws_subnet.pub-sn-01.id, aws_subnet.pub-sn-02.id]
}

output "ansible-SG-ID" {
  value = aws_security_group.Bastion-Ansible_SG.id
}

output "docker-SG" {
  value = aws_security_group.Docker_SG.id
}

output "bastion-SG-ID" {
  value = aws_security_group.Bastion-Ansible_SG.id
}

output "jenkins-SG-ID" {
  value = aws_security_group.Jenkins_SG.id
}

output "sonarqube-SG-ID" {
  value = aws_security_group.Sonarqube_SG.id
}

output "nexus-SG-ID" {
  value = aws_security_group.Nexus_SG.id
}

output "rds-SG-ID" {
  value = aws_security_group.MYSQL_RDS_SG.id
}