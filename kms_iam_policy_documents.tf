##########################
### primary key policy ###
##########################

data "aws_iam_policy_document" "kms_primary_key_policy" {
  source_policy_documents = concat(
    var.custom_iam_policy_statement,
    [
      var.enable_default_policy ? data.aws_iam_policy_document.default.json : null,
      length(var.key_users) > 0 ? data.aws_iam_policy_document.common_usage.json : null,
      length(var.key_administrators) > 0 ? data.aws_iam_policy_document.key_administration.json : null,
    ]
  )
}

data "aws_iam_policy_document" "default" {
  count = var.enable_default_policy ? 0 : 1

  statement {
    sid       = "Default"
    actions   = ["kms:*"]
    resources = [aws_kms_key.primary_key.arn]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

data "aws_iam_policy_document" "common_usage" {
  count = length(var.key_users) > 0 ? 1 : 0

  statement {
    sid = "KeyUsage"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = [aws_kms_key.primary_key.arn]

    principals {
      type        = "AWS"
      identifiers = var.key_users
    }
  }
}

data "aws_iam_policy_document" "key_administration" {
  count = length(var.key_administrators) > 0 ? 1 : 0

  statement {
    sid = "KeyAdministration"
    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
      "kms:ReplicateKey",
      "kms:ImportKeyMaterial"
    ]
    resources = [aws_kms_key.primary_key.arn]

    principals {
      type        = "AWS"
      identifiers = var.key_administrators
    }
  }
}

##########################
### replica key policy ###
##########################

data "aws_iam_policy_document" "kms_replica_key_policy" {
  source_policy_documents = concat(
    var.replica_custom_iam_policy_statement,
    [
      var.enable_default_policy ? data.aws_iam_policy_document.default.json : null,
      length(var.replica_key_users) > 0 ? data.aws_iam_policy_document.replica_common_usage.json : null,
      length(var.replica_key_administrators) > 0 ? data.aws_iam_policy_document.replica_key_administration.json : null,
    ]
  )
}

data "aws_iam_policy_document" "replica_common_usage" {
  count = length(var.replica_key_users) > 0 ? 1 : 0

  statement {
    sid = "KeyUsage"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = [aws_kms_key.replica_key.arn]

    principals {
      type        = "AWS"
      identifiers = var.replica_key_users
    }
  }
}

data "aws_iam_policy_document" "replica_key_administration" {
  count = length(var.replica_key_administrators) > 0 ? 1 : 0

  statement {
    sid = "KeyAdministration"
    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
      "kms:ReplicateKey",
      "kms:ImportKeyMaterial"
    ]
    resources = [aws_kms_key.replica_key.arn]

    principals {
      type        = "AWS"
      identifiers = var.replica_key_administrators
    }
  }
}
