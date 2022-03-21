# variables.tf | Auth and Application variables

variable "hosted_zone" {
  type = string
}

variable "module_name" {
  type        = string
  description = "module name"
}

variable "environment" {
  type        = string
  description = "Environment"
}