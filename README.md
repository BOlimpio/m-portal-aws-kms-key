# AWS KMS

## Purpose

Terraform module which create KMS CMK(Customer Managed Key) and policies on AWS.

## Features

Below features are supported:

  * Pre-configured Key policy for Admin, TFE and SSO Users  
  * Key rotation support
  * Option to add other aws accounts to use the key for chryptograpic purpose
  * KMS grant policy

## Prerequisites

Requires terraform version >= 0.12

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
|account-number|AWS Account number where the KMS key needs to be created.|string|-|Yes|
|key-name|A friendly name for the key to create i.e. my-account-primary-encryption-key.|string|-|Yes|
|key-usage|The intended use of the key. Valid values: `ENCRYPT_DECRYPT`, `SIGN_VERIFY`, or `GENERATE_VERIFY_MAC`.|string|`ENCRYPT_DECRYPT`|No|
|key-description|The description of the key as viewed in AWS console.|string|`null`|No|
|customer-master-key-spec|Specify the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: `SYMMETRIC_DEFAULT`, `RSA_2048`, `RSA_3072`, `RSA_4096`, `HMAC_256`, `ECC_NIST_P256`, `ECC_NIST_P384`, `ECC_NIST_P521`, or `ECC_SECG_P256K1`.|string|`SYMMETRIC_DEFAULT`|No|
|is-enabled|Whether the key is enabled.|bool|`true`|No|
|switch-tfe-role-to-user|Does the TFE standard role `tfRole` need to be changed to user `tf-user` for the key management if tfe role doesn't exist in account.|bool|`false`|No|
|services|AWS service names that need access to the KMS key - for example `cloudtrail.amazonaws.com`.|list(string)|`[]`|No|
|enable-key-rotation|Whether key rotation is enabled.|bool|`false`|No|
|multi-region|Whether the KMS key is a multi-Region key.|bool|`false`|No|
|additional-key-policy-documents|List of additional Key policy json documents that are merged together into the pre-defined policy.|list(string)|`null`|No|
|override-key-policy-documents|List of Key policy json documents that need to override any pre-defined policy by merging, when merging statements with non-blank sids will override statements with the same sid from documents in the list.|list(string)|`null`|No|
|enable-default-policy|Default key policy statement gives permission to control the key to the account principal, which represents the AWS account and its administrators, including the account root user. Unlike other AWS resource policies, an AWS KMS key policy does not automatically give permission to the account or any of its identities.|bool|`true`|No|
|sso-users|Key permission for SSO users.|list(string)|`null`|Yes|
|granter-users-arns|List of granters who can create temproary token and id for a grantee like other aws services to use KMS for chryptographic usage on their behalf.|list(string)|`null`|No|
|other-aws-account-ids|List of other aws account ids which need access to use the key for cryptographic operations.|list(string)|`null`|No|

## Outputs

| Name | Description | Type |
|------|-------------|:----:|
|kms_key|all exported kms key attributes|map|