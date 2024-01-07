provider "aws" {
  alias  = "replica_region"
  region = var.replica_region
}

resource "aws_kms_key" "primary_key" {
  description              = var.key_description
  key_usage                = var.key_usage
  customer_master_key_spec = var.customer_master_key_spec
  is_enabled               = var.is_enabled
  enable_key_rotation      = var.enable_key_rotation
  multi_region             = var.multi_region
  deletion_window_in_days  = var.deletion_window_in_days
  policy                   = data.aws_iam_policy_document.kms_key_policy.json

  tags = merge(
    {
      Name = var.key_name
    },
    var.additional_tags
  )
}

resource "aws_kms_alias" "key_alias" {
  target_key_id = aws_kms_key.primary_key.key_id
  name          = "alias/${var.key_name}"
}

resource "aws_kms_key_policy" "primary_key_policy" {
  key_id = aws_kms_key.primary_key.id
  policy = data.aws_iam_policy_document.kms_primary_key_policy.json
}

resource "aws_kms_replica_key" "replica_key" {
  count = var.create_replica && var.multi_region ? 1 : 0
  
  provider = aws.replica_region

  deletion_window_in_days = var.deletion_window_in_days
  description             = var.description_replica
  primary_key_arn         = aws_kms_key.primary_key.arn
  enabled                 = var.is_enabled_replica

  tags = merge(
    {
      Name = var.key_replica_name
    },
    var.additional_tags
  )
}

resource "aws_kms_key_policy" "replica_key_policy" {
  count = var.create_replica && var.multi_region ? 1 : 0

  key_id = aws_kms_replica_key.replica_key.id
  policy = data.aws_iam_policy_document.kms_replica_key_policy.json
}