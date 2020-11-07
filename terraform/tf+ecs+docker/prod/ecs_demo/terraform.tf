terraform {
  backend "s3" {
    bucket = "bruno-terraform-plans"
    key    = "terraform_ecs_demo.tfstate"
    region = "us-east-1"
  }
}
