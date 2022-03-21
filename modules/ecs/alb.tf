resource "aws_alb" "application_load_balancer" {
  name               = "${var.module_name}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [var.public_security_group]

  tags = {
    Name        = "${var.module_name}-alb"
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = "${var.module_name}-${var.environment}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  dynamic "health_check" {
    for_each = var.lb_health_check_config
    content {
      healthy_threshold   = health_check.value.healthy_threshold
      interval            = health_check.value.interval
      protocol            = health_check.value.protocol
      matcher             = health_check.value.matcher
      timeout             = health_check.value.timeout
      path                = health_check.value.path
      unhealthy_threshold = health_check.value.unhealthy_threshold
    }
  }

  tags = {
    Name        = "${var.module_name}-lb-tg"
    Environment = var.environment
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  for_each          = var.lb_listener_config
  port              = lookup(each.value, "port", "443")
  protocol          = lookup(each.value, "protocol", "HTTPS" )

  ssl_policy      = lookup(each.value, ssl_policy, "ELBSecurityPolicy-2016-08")
  certificate_arn = lookup(each.value, certificate_arn, "")
  dynamic "default_action" {
    for_each = each.value.default_action
    content {
      target_group_arn = default_action.value.target_group_arn
      type             = default_action.value.type
    }
  }
}
