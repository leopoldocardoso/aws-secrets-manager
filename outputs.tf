output "secret_name" {
  description = "Secret Name"
  value       = module.secrets-manager.secret_name
}