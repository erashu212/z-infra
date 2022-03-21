variable "module_name" {
  type        = string
  description = "module name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "fqdn" {
  type        = string
  description = "Fully qualified domain name"
}

variable "certificate_arn" {
  type        = string
  description = "Certificate arn"
}

variable "integration_uri" {
  type = string
}

variable "apig_vpc_subnet_ids" {
  type        = list(string)
  description = "Subnet Ids of VPC to associate a link"
}