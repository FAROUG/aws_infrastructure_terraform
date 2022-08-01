terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  profile    = var.AWS_SWITCH_ROLE
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = var.AWS_REGION
}
