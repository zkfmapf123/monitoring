########################################################################
### aws iam role
########################################################################
resource "aws_iam_role" "ec2_cloudwatch_role" {
  name = "ec2-cloudwatch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

########################################################################
### iam policy
########################################################################
resource "aws_iam_policy" "ec2_cloudwatch_policy" {
  name = "ec2-cloudwatch-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeVolumes",
          "ec2:DescribeTags",
          "cloudwatch:PutMetricData",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudwatch_attchment" {
  policy_arn = aws_iam_policy.ec2_cloudwatch_policy.arn
  role       = aws_iam_role.ec2_cloudwatch_role.name
}
