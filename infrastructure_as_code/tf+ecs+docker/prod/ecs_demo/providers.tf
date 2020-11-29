variable "provider_region" {
  type        = string
  default     = "eu-west-1"
  description = "The default region when using the provider"
}

provider "aws" {
  region  = var.provider_region
  version = "~> 2.63.0"
}

provider "template" {
  version = "~> 2.1.2"
}
