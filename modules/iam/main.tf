# main.tf | IAM Role Policies

data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = [var.service_identifiers]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.module_name
  assume_role_policy = data.aws_iam_policy_document.this.json
  tags               = {
    Name        = "${var.module_name}-iam-role"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = var.policy_arn //"arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

