variable "vpc_id" {
  type        = string
  description = "Provide vpc id"
}

variable "ingress" {
  type = map(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
  }))
  description = "Details of inbound rules of security groups"
}

variable "egress" {
  type = map(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
  }))
  description = "Details of outbound rules of security groups"
}

variable "module_name" {
  type        = string
  description = "module name"
}

variable "environment" {
  type        = string
  description = "Environment"
}