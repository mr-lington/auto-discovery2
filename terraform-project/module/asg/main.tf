# Create Launch Template
resource "aws_launch_template" "stage_lt" {
  name_prefix                 = "stage-asg-lt"
  image_id                    = var.ami
  instance_type               = var.instance-type
  vpc_security_group_ids      = [var.stage-SG-ID]
  key_name                    = var.keypair
  
  user_data                   = base64encode(templatefile("${path.root}/module/asg/docker-script.sh", {
    var1 = var.nexus-ip,
    var2 = var.newrelic-user-licence,
    var3 = var.newrelic-acct-id
  }))
}

#Create AutoScaling Group
resource "aws_autoscaling_group" "stage-asg" {
  name                      = var.stage-asg-name
  desired_capacity          = 1
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 120
  health_check_type         = "EC2"
  force_delete              = true
  vpc_zone_identifier       = var.vpc-zone-identifier
  target_group_arns         = [var.tg-arn]
  launch_template {
    id      = aws_launch_template.stage_lt.id
    version = "$Latest"
  }
  tag{
    key                 = "Name"
    value               = "stage-asg"
    propagate_at_launch = true
  }
}

#Create ASG Policy
resource "aws_autoscaling_policy" "asg-policy" {
  name                      =  var.asg-policy
  adjustment_type           = "ChangeInCapacity"
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.stage-asg.id
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60.0
  }
}


# Create Launch Template
resource "aws_launch_template" "prod_lt" {
  name_prefix                 = "prod-asg-lt"
  image_id                    = var.ami
  instance_type               = var.instance-type
  vpc_security_group_ids      = [var.prod-SG-ID]
  key_name                    = var.keypair
    user_data                   = base64encode(templatefile("${path.root}/module/asg/docker-script.sh", {
    var1 = var.nexus-ip,
    var2 = var.newrelic-user-licence,
    var3 = var.newrelic-acct-id
  })) 
}



#Create AutoScaling Group
resource "aws_autoscaling_group" "prod-asg" {
  name                      = var.prod-asg-name
  desired_capacity          = 2
  max_size                  = 3
  min_size                  = 2
  health_check_grace_period = 120
  health_check_type         = "EC2"
  force_delete              = true
  vpc_zone_identifier       = var.vpc-zone-identifier
  target_group_arns         = [var.tg-arn2]
  launch_template {
    id      = aws_launch_template.prod_lt.id
    version = "$Latest"
  }
  tag{
    key                 = "Name"
    value               = "prod-asg"
    propagate_at_launch = true
  }
}

#Create ASG Policy
resource "aws_autoscaling_policy" "asg-policy2" {
  name                      =  var.asg-policy
  adjustment_type           = "ChangeInCapacity"
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.prod-asg.id
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60.0
  }
}

