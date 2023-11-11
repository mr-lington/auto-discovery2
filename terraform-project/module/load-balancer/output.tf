output "stage-tg-arn" {
 value = aws_lb_target_group.stage_target_group.arn
}
output "stage-lb-dns" {
 value = aws_lb.stage-lb.dns_name
}
output "stage-zone-id" {
 value = aws_lb.stage-lb.zone_id
}

output "prod-tg-arn" {
 value = aws_lb_target_group.prod_target-group.arn
}

output "prod-lb-dns" {
 value = aws_lb.prod-lb.dns_name
}
output "prod-zone-id" {
 value = aws_lb.prod-lb.zone_id
}

output "jenkins-dns" {
  value = aws_elb.lb.dns_name
}

output "jenkins-zone-id" {
  value = aws_elb.lb.zone_id
}