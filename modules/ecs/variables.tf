variable "module_name" {
  type        = string
  description = "module name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of subnets to be associated with load balancer"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of subnets to be associated with ECS"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to associate with load balancer"
}

variable "public_security_group" {
  type        = string
  description = "security group for load balancer"
}

variable "private_security_group" {
  type        = string
  description = "security group for load balancer"
}


variable "lb_health_check_config" {
  description = "Health check configuration details of load balancer"
  type        = map(object({
    healthy_threshold   = string
    interval            = string
    protocol            = string
    matcher             = string
    timeout             = string
    path                = string
    unhealthy_threshold = string
  }))
  default = {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/v1/healthcheck"
    unhealthy_threshold = "2"
  }
}

variable "lb_listener_config" {
  type = list(map(object({
    port            = string
    protocol        = string
    ssl_policy      = string
    certificate_arn = string
    default_action  = map(object({
      type             = string
      target_group_arn = string
    }))
  })))
  default = [
    {
      port            = "443"
      protocol        = "HTTPS"
      certificate_arn = ""
      ssl_policy      = "ELBSecurityPolicy-2016-08"
      default_action  = {
        type             = "forward"
        target_group_arn = ""
      }
    }
  ]
}

variable "container_definition" {
  type = map(object({
    imageUrl     = string
    cpu          = number
    memory       = number
    essential    = bool
    portMappings = list(map(object({
      containerPort = number
      hostPort      = number
    })))
    volume = map(object({
      name      = string
      host_path = string
    }))
  }))
  description = "Url of docker image"
}

variable "ecs_iam_role_arn" {
  type        = string
  description = "ECS IAM execution role arn"
}