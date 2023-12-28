# m-portal-aws-kms-key
This Terraform module facilitates the creation and management of keys in the AWS Key Management Service (KMS), including the option to create keys replicated across multiple regions. The module provides flexibility by allowing users to define custom IAM policy statements and offers predefined policies for common scenarios. **For additional resources, examples, and community engagement**, check out the portal [Cloud Collab Hub](https://cloudcollab.com) :cloud:.

## Usage
**Loading...** ⌛

For more detailed examples and use cases, check out the files in the how-to-usage directory. They provide additional scenarios and explanations for leveraging the features of the aws_kms_key module.

## Module Inputs

| Name                         | Type                 | Description                                                                                                      | Default Value | Required      |
| ---------------------------- | -------------------- | ---------------------------------------------------------------------------------------------------------------- | ------------- | ------------- |
| key_name                     | string               | The name of the KMS key.                                                                                         |               | Yes           |
| key_description              | string               | The description of the KMS key.                                                                                  |               | Yes           |
| key_usage                    | string               | Specifies the intended use of the KMS key. Valid values: ENCRYPT_DECRYPT or SIGN_VERIFY.                           | ENCRYPT_DECRYPT| No            |
| customer_master_key_spec     | string               | Specifies whether the KMS key is a standard key or a FIPS-compliant key. Valid values: SYMMETRIC_DEFAULT or RSA_3072. | SYMMETRIC_DEFAULT| No            |
| is_enabled                   | bool                 | Specifies whether the KMS key is enabled.                                                                       | true          | No            |
| enable_key_rotation          | bool                 | Specifies whether key rotation is enabled.                                                                     | false         | No            |
| multi_region                 | bool                 | Specifies whether the KMS key can be replicated into different regions.                                          | false         | No            |
| additional_tags              | map(string)          | A map of default tags to apply to the KMS key.                                                                  | {}            | No            |
| deletion_window_in_days      | number               | The number of days in the key deletion period. Must be between 7 and 30 days.                                     | 30            | No            |

#### Replica Variables

| Name                         | Type                 | Description                                                                                                      | Default Value | Required      |
| ---------------------------- | -------------------- | ---------------------------------------------------------------------------------------------------------------- | ------------- | ------------- |
| create_replica               | bool                 | If true, create a replicated KMS key.                                                                           | false         | No            |
| key_replica_name             | string               | Name of the replicated KMS key.                                                                                 | ReplicaKey    | No            |
| description_replica          | string               | Description of the replicated KMS key.                                                                         |               | No            |
| is_enabled_replica           | bool                 | If true, the replicated KMS key will be enabled.                                                                | true          | No            |
| policy_replica               | string               | Policy for the replicated KMS key.                                                                              |               | No            |
| replica_region               | string               | The region where the replicated KMS key will be created.                                                        | null          | No            |

#### Policy Variables

| Name                         | Type                 | Description                                                                                                      | Default Value | Required      |
| ---------------------------- | -------------------- | ---------------------------------------------------------------------------------------------------------------- | ------------- | ------------- |
| enable_default_policy        | bool                 | Enable the default policy allowing account-wide access to all key operations.                                   | true          | No            |
| key_administrators           | list(string)         | List of AWS principals who are key administrators.                                                              | []            | No            |
| key_users                    | list(string)         | List of AWS principals who are key users.                                                                       | []            | No            |
| custom_iam_policy_statement  | list(map(string))    | List of custom policy statements.                                                                               | []            | No            |
| replica_key_administrators   | list(string)         | List of AWS principals who are key administrators for the replica key.                                          | []            | No            |
| replica_key_users            | list(string)         | List of AWS principals who are key users for the replica key.                                                   | []            | No            |
| replica_custom_iam_policy_statement | list(map(string)) | List of custom policy statements for the replica key.                                                           | []            | No            |

### Module Outputs

| Name             | Description                                   | Exported Attributes                                       |
| ---------------- | --------------------------------------------- | --------------------------------------------------------- |
| kms_key          | All exported KMS key attributes.              | aws_kms_key.primary_key                                    |
| kms_replica_key  | All exported KMS replica key attributes.      | aws_kms_replica_key.replica_key                            |

## How to Use Output Attributes
primary_key_arn = module.example_kms.kms_key.arn
**OR**
replica_key_arn = module.example_kms.kms_replica_key["arn"]

## License

This project is licensed under the MIT License - see the [MIT License](https://opensource.org/licenses/MIT) file for details.

## Contributing

Contributions are welcome! Please follow the guidance below for details on how to contribute to this project:

1. Fork the repository
2. Create a new branch: `git checkout -b feature/your-feature-name`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/your-feature-name`
5. Open a pull request
