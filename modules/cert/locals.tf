locals {
  fqdn = "${var.module_name}.${var.environment}.${var.hosted_zone}"
  dvo          = flatten(aws_acm_certificate.this.*.domain_validation_options)
}