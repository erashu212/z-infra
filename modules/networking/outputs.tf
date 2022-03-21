output "vpc" {
  value = {
    id  = aws_vpc.this.id
    arn = aws_vpc.this.arn
  }
}

output "igw" {
  value = {
    id  = aws_internet_gateway.this.id
    arn = aws_internet_gateway.this.arn
  }
}

output "public_subnets" {
  value = [aws_subnet.public.*.id]
}

output "private_subnets" {
  value = [aws_subnet.private.*.id]
}