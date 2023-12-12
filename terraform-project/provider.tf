# Configure the AWS Provider
provider "aws" {
  # region  = var.region  
  # profile = var.profile 
  region     = data.vault_generic_secret.aws-cred.data["region"]
  access_key = data.vault_generic_secret.aws-cred.data["aws_access_key_id"]
  secret_key = data.vault_generic_secret.aws-cred.data["aws_secret_access_key"]
}

provider "vault" {
  address = "https://greatestshalomventures.com"
  token   = var.token
}
data "vault_generic_secret" "aws-cred" {
  path = "secrett/aws-cred"
}
data "vault_generic_secret" "database" {
  path = "secrett/database"
}