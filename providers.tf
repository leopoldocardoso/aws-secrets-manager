terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.39.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Objective   = "Learn Terraform"
      Environment = "Class Linux Tips"
      "project"   = "descomplicando terraform"
    }
  }
}