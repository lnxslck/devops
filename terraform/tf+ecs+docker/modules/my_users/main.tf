# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user

resource "aws_iam_user" "ecs_deployer" {
  name = "ecs_deployer"
  path = "/ecs/"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy

resource "aws_iam_user_policy" "ecs_deployer_policy" {
  name = "ecs_deployer_policy"
  user = aws_iam_user.ecs_deployer.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecs:RegisterTaskDefinition",
                "ecs:DescribeTaskDefinitions",
                "ecs:ListTaskDefinitions",
                "ecs:CreateService",
                "ecs:UpdateService",
                "ecs:DescribeServices",
                "ecs:ListServices"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": ["iam:PassRole"],
            "Resource": "arn:aws:iam::*:role/ecs/*"
        }
    ]
}
EOF
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key

resource "aws_iam_access_key" "ecs_deployer" {
  user = aws_iam_user.ecs_deployer.name
}
