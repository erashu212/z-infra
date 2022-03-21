variable "module_name" {
  type        = string
  description = "module name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "service_identifiers" {
  type = list(string)
  description = "List of service identifiers allowed for assume role policy"
}

variable "policy_arn" {
  type = string
}