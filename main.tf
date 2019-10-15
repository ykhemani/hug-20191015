variable "vault_role_id" {}
variable "vault_secret_id" {}
variable "vault_api" {}

provider "vault" {
  address = var.vault_api
  auth_login {
    path = "auth/approle/login"
    parameters = {
      role_id = var.vault_role_id
      secret_id = var.vault_secret_id
    }
  }
}

data "vault_generic_secret" "aws_creds" {
  path = "aws/creds/tfe-aws"
}

output "access_key" {
  value = data.vault_generic_secret.aws_creds.data["access_key"]
}

output "secret_key" {
  value = data.vault_generic_secret.aws_creds.data["secret_key"]
}

