# create policy document assume role for EC2 instance
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# create policy document for KMS key for vault
data "aws_iam_policy_document" "vault-kms-unseal" {
  statement {
    sid       = "VaultKMSUnseal"
    effect    = "Allow"
    resources = [aws_kms_key.vault.arn]

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey",
    ]
  }
}

#  create iam role and attach the policy document
resource "aws_iam_role" "vault-kms-unseal" {
  name               = "vault-kms-role1"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

#  create iam role policy and attach the policy document
resource "aws_iam_role_policy" "vault-kms-unseal" {
  name   = "Vault-KMS-Unseal1"
  role   = aws_iam_role.vault-kms-unseal.id
  policy = data.aws_iam_policy_document.vault-kms-unseal.json
}

# create iam instance profile 
resource "aws_iam_instance_profile" "vault-kms-unseal" {
  name = "vault-kms-unseal1"
  role = aws_iam_role.vault-kms-unseal.name
}