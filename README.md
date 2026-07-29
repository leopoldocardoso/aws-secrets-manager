
# aws-secrets-manager

### Provisionamento de secrets na AWS com Terraform

Consome o módulo próprio [`terraform-aws-secrets-manager`](https://github.com/leopoldocardoso/terraform-aws-secrets-manager) para criar secrets com **senhas geradas automaticamente**, caracteres especiais customizáveis, janela de recuperação configurável e tags.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.39.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secrets-manager"></a> [secrets-manager](#module\_secrets-manager) | git::https://github.com/leopoldocardoso/terraform-aws-secrets-manager.git | v0.1.6 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_random_password"></a> [create\_random\_password](#input\_create\_random\_password) | Determines whether a random password will be generated and stored in the secret | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | A Description of the secret | `string` | `"Secret with custom password length and special characters"` | no |
| <a name="input_name"></a> [name](#input\_name) | Friendly name of the new secret | `string` | n/a | yes |
| <a name="input_override_special"></a> [override\_special](#input\_override\_special) | Supply your own list of special characters to use for string generation | `string` | `"!#$%&*()-_=+[]{}:?"` | no |
| <a name="input_random_password_length"></a> [random\_password\_length](#input\_random\_password\_length) | The length of the generated random password | `number` | `32` | no |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | Number of days that AWS Secrets Manager waits before it can delete the secret. | `number` | `7` | no |
| <a name="input_special"></a> [special](#input\_special) | Include special characters in the random password | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the secret | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_name"></a> [secret\_name](#output\_secret\_name) | Secret Name |
<!-- END_TF_DOCS -->


## How to Use

This configuration uses the Terraform AWS Secrets Manager module to create secrets in AWS.

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- AWS CLI configured with appropriate credentials
- AWS account with permissions to create Secrets Manager resources

### Step-by-Step Deployment

#### 1. Configure AWS credentials
```bash
# Option A: Using AWS CLI
aws configure

# Option B: Using environment variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

#### 2. Review and customize variables
Edit the `terraform.tfvars` file to customize your secret:

```hcl
name                   = "my-secret-name"
description            = "My secret description"
random_password_length = 32
special                = true
override_special       = "!#$%&*()-_=+[]{}:?"
```

#### 3. Initialize Terraform
```bash
terraform init
```

This will download the required providers and modules.

#### 4. Review the execution plan
```bash
terraform plan
```

Review the resources that will be created.

#### 5. Apply the configuration
```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment.

#### 6. Verify the secret was created
```bash
# List secrets
aws secretsmanager list-secrets

# Get secret value
aws secretsmanager get-secret-value --secret-id <your-secret-name>
```

### Outputs

After deployment, you can view the outputs:

```bash
terraform output
```

Available outputs:
- `secret_name`: The name of the created secret

### Update Secret Value

If you need to update the secret value manually:

```bash
aws secretsmanager put-secret-value \
  --secret-id <your-secret-name> \
  --secret-string '{"username":"admin","password":"your-password"}'
```

### Cleanup

To destroy the created resources:

```bash
terraform destroy
```

**Note:** The secret will be scheduled for deletion based on the `recovery_window_in_days` value (default: 7 days).

### Troubleshooting

**Issue:** `Error: creating Secrets Manager Secret: InvalidRequestException: You can't create this secret because a secret with this name is already scheduled for deletion.`

**Solution:** Wait for the recovery window to pass, or restore the secret:
```bash
aws secretsmanager restore-secret --secret-id <your-secret-name>
```

**Issue:** `Error: No valid credential sources found`

**Solution:** Configure your AWS credentials using `aws configure` or set environment variables.
