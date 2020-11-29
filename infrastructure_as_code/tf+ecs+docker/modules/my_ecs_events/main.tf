# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic

resource "aws_sns_topic" "ecs_events" {
  name = "ecs_events_${var.environment}_${var.cluster}"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity

data "aws_caller_identity" "current" {}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region

data "aws_region" "current" {
  current = true
}

data "template_file" "ecs_task_stopped" {
  template = <<EOF
{
  "source": ["aws.ecs"],
  "detail-type": ["ECS Task State Change"],
  "detail": {
    "clusterArn": ["arn:aws:ecs:$${aws_region}:$${account_id}:cluster/$${cluster}"],
    "lastStatus": ["STOPPED"],
    "stoppedReason": ["Essential container in task exited"]
  }
}
EOF

  vars {
    account_id = data.aws_caller_identity.current.account_id
    cluster    = var.cluster
    aws_region = data.aws_region.current.name
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule

resource "aws_cloudwatch_event_rule" "ecs_task_stopped" {
  name          = "${var.environment}_${var.cluster}_task_stopped"
  description   = "${var.environment}_${var.cluster} Essential container in task exited"
  event_pattern = data.template_file.ecs_task_stopped.rendered
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target

resource "aws_cloudwatch_event_target" "event_fired" {
  rule  = aws_cloudwatch_event_rule.ecs_task_stopped.name
  arn   = aws_sns_topic.ecs_events.arn
  input = "{ \"message\": \"Essential container in task exited\", \"account_id\": \"${data.aws_caller_identity.current.account_id}\", \"cluster\": \"${var.cluster}\"}"
}
