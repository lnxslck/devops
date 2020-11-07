variable "id" {}

variable "name" {}

variable "schedule" {
  description = "If the instance is running on a Schedule. Defaults to empty/null"
  default     = ""
}

variable "snapshot" {
  description = "If the instance volume is to be taken snapshots. Defaults to empty/null"
  default     = ""
}

variable "alias" {
  default = []
}

variable "instance_type" {
  description = "The type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance."
  default     = "t3a.medium"
}

variable "aws_route53_zone_id" {
  description = "The Hosted Zone ID"
  type    = string
}

variable "disks" {
  default = []
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = ["sg-32876a5d", "sg-4ea34c21"]
}

variable "my_instance_ebs_optimized_default" {
  type        = bool
  description = "If the instance is ebs optimized, used whenever ebs_optimized is not specified for the instance. Defaults true"
  default     = true
}

variable "my_route53_record_ttl" {
  type    = string
  default = "300"
}

variable "my_instance_disable_api_termination" {
  type        = bool
  description = "If the instance has api_termination disabled, used whenever api_termination is not specified for the instance. Defaults true"
  default     = true
}

variable "my_instance_source_dest_check" {
  type        = bool
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. Defaults true"
  default     = true
}

variable "my_instance_iam_instance_profile" {
  type        = string
  description = "IAM profile for the instance"
  default     = ""
}

variable "my_key_name" {
  type    = string
  default = "tiagovarela"
}

data "template_file" "bootstrap" {
  template = "${file("${path.module}/../bootstraps/bootstrap.sh")}"
  vars = {
    id = "${var.id}"
  }
}

data "aws_ami" "ubuntu_xenial" {
  most_recent = true
  owners      = ["aws-marketplace"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-*-amd64-server-*"]
  }
}

data "aws_ami" "ubuntu_bionic" {
  most_recent = true
  owners      = ["aws-marketplace"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-*-amd64-server-*"]
  }
}
