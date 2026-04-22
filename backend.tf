terraform {

  backend "s3" {
    bucket = "terraform-state-lnxtips"
    key    = "secrets-manager/terraform.tfstate"
    region = "us-east-1"
  }
}