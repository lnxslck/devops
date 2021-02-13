variable "region" {
  default = "us-east-1"
}

variable "amis" {
  type = map(string)
  default = {
    "us-east-1" = "ami-00bc4a48c20aeae77"
    "us-west-2" = "ami-fc0b939c"
  }
}

variable "aws_access_key_id" {}

variable "aws_secret_access_key" {}
