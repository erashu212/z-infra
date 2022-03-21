# API definition
resource "aws_apigatewayv2_api" "this" {
  name                         = var.module_name
  protocol_type                = "HTTP"
  disable_execute_api_endpoint = true
}

resource "aws_apigatewayv2_vpc_link" "this" {
  name               = "${var.module_name}-link"
  security_group_ids = [
    #    aws_security_group.load_balancer_security_group.id
  ]
  subnet_ids = [
    var.apig_vpc_subnet_ids
  ]
  tags = {
    Name = var.environment
  }
}

#Integrations for the api
resource "aws_apigatewayv2_integration" "this" {
  api_id           = aws_apigatewayv2_api.this.id
  integration_type = "HTTP_PROXY"
  connection_id    = aws_apigatewayv2_vpc_link.this.id

  connection_type    = "VPC_LINK"
  integration_method = "ANY"
  integration_uri    = var.integration_uri
}

resource "aws_apigatewayv2_route" "this" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.this.id}"
}

resource "aws_apigatewayv2_stage" "this" {
  name        = "$default"
  auto_deploy = true
  api_id      = aws_apigatewayv2_api.this.id
}

resource "aws_apigatewayv2_domain_name" "this" {
  domain_name = var.fqdn
  domain_name_configuration {
    certificate_arn = var.certificate_arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}
