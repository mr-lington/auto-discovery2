# Created Application Load balancer
resource "aws_lb" "stage-lb" {
  name               = "stage-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.stage-lb-SG]
  subnets            = var.subnets
  enable_deletion_protection = false
  tags = {
  Name = "stage-alb" 
  }
}

# Created Load balancer Listener for http
resource "aws_lb_listener" "stage_lb_listener" {
  load_balancer_arn      = aws_lb.stage-lb.arn
  port                   = "80"
  protocol               = "HTTP"
  default_action {
    type                 = "forward"
    target_group_arn     = aws_lb_target_group.stage_target_group.arn
    }
}

# Creating a Load balancer Listener for https access
resource "aws_lb_listener" "stage_lb_listener_https" {
  load_balancer_arn      = aws_lb.stage-lb.arn
  port                   = "443"
  protocol               = "HTTPS"
  ssl_policy             = "ELBSecurityPolicy-2016-08"
  certificate_arn        = var.certificate-arn
  default_action {
    type                 = "forward"
    target_group_arn     = aws_lb_target_group.stage_target_group.arn
  }
}

# Creating Target Group
resource "aws_lb_target_group" "stage_target_group" {
  name_prefix      = "tg-lb"
  port             = 8080
  protocol         = "HTTP"
  vpc_id           = var.vpc-id

  health_check {
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 5
  }
}

# Creating Application Load balancer
resource "aws_lb" "prod-lb" {
  name               = "prod-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.prod-lb-SG]
  subnets            = var.subnets
  enable_deletion_protection = false
  tags = {
    Environment = "prod-lb"
  }
}

#Creating a Load balancer Listener for http access
resource "aws_lb_listener" "prod_lb_listener" {
  load_balancer_arn = aws_lb.prod-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_target-group.arn
  }
}

#Creating a Load balancer Listener for https access
resource "aws_lb_listener" "prod_lb_listener_https" {
  load_balancer_arn = aws_lb.prod-lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate-arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_target-group.arn
  }
}

#Creating Target Group
resource "aws_lb_target_group" "prod_target-group" {
  name     = "prod-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc-id

  health_check {
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 5
  }
}

# # Create a jenkins load balancer
# resource "aws_elb" "lb" {
#   name               = "jenkins-alb"
#   subnets = var.subnets-id
#   security_groups = [var.jenkins-SG]

#   listener {
#     instance_port     = 8080
#     instance_protocol = "http"
#     lb_port           = 80
#     lb_protocol       = "http"
#   }

#   # listener {
#   #   instance_port      = 8000
#   #   instance_protocol  = "http"
#   #   lb_port            = 443
#   #   lb_protocol        = "https"
#   #   ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
#   # }

#   health_check {
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 3
#     target              = "TCP:8080"
#     interval            = 30
#   }

#   instances                   = [var.jenkins-instance-id]
#   cross_zone_load_balancing   = true
#   idle_timeout                = 400
#   connection_draining         = true
#   connection_draining_timeout = 400

#   tags = {
#     Name = "jenkins-alb"
#   }
# }

# Created Application Load balancer
resource "aws_lb" "jenkins-lb" {
  name               = "jenkins-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.jenkins-lb-SG]
  subnets            = var.subnets
  enable_deletion_protection = false
  tags = {
  Name = "jenkins-alb" 
  }
}

# Created Load balancer Listener for http
resource "aws_lb_listener" "jenkins_lb_listener" {
  load_balancer_arn      = aws_lb.jenkins-lb.arn
  port                   = "80"
  protocol               = "HTTP"
  default_action {
    type                 = "forward"
    target_group_arn     = aws_lb_target_group.jenkins_target_group.arn
    }
}

# Creating a Load balancer Listener for https access
resource "aws_lb_listener" "jenkins_lb_listener_https" {
  load_balancer_arn      = aws_lb.jenkins-lb.arn
  port                   = "443"
  protocol               = "HTTPS"
  ssl_policy             = "ELBSecurityPolicy-2016-08"
  certificate_arn        = var.certificate-arn
  default_action {
    type                 = "forward"
    target_group_arn     = aws_lb_target_group.jenkins_target_group.arn
  }
}

# Creating Target Group
resource "aws_lb_target_group" "jenkins_target_group" {
  name_prefix      = "tg-lb"
  port             = 8080
  protocol         = "HTTP"
  vpc_id           = var.vpc-id

  health_check {
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 5
  }
}

resource "aws_lb_target_group_attachment" "jenkins-tg-attachement" {
  target_group_arn = aws_lb_target_group.jenkins_target_group.arn
  target_id        = var.jenkins-instance-id
  port             = 8080
}
