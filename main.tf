module "secrets-manager" {
  source                 = "git::https://github.com/leopoldocardoso/terraform-aws-secrets-manager.git?ref=v0.1.6"
  name                   = var.name
  description            = var.description
  random_password_length = var.random_password_length
  override_special       = var.override_special
  tags                   = var.tags
}