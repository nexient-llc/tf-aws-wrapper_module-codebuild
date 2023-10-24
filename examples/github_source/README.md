# codebuild

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_codebuild"></a> [codebuild](#module\_codebuild) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Stage action name for the CodeBuild project. | `string` | `"build"` | no |
| <a name="input_naming_prefix"></a> [naming\_prefix](#input\_naming\_prefix) | Prefix for the provisioned resources. | `string` | `"platform"` | no |
| <a name="input_codebuild_iam"></a> [codebuild\_iam](#input\_codebuild\_iam) | Additional IAM actions to add to CodeBuild IAM role. | `string` | `null` | no |
| <a name="input_buildspec"></a> [buildspec](#input\_buildspec) | Optional buildspec declaration to use for building the project | `string` | `""` | no |
| <a name="input_source_type"></a> [source\_type](#input\_source\_type) | The type of repository that contains the source code to be built. Valid values for this parameter are: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB\_ENTERPRISE, BITBUCKET or S3 | `string` | `"CODEPIPELINE"` | no |
| <a name="input_source_location"></a> [source\_location](#input\_source\_location) | The location of the source code from git or s3 | `string` | `""` | no |
| <a name="input_artifact_type"></a> [artifact\_type](#input\_artifact\_type) | The build output artifact's type. Valid values for this parameter are: CODEPIPELINE, NO\_ARTIFACTS or S3 | `string` | `"CODEPIPELINE"` | no |
| <a name="input_artifact_location"></a> [artifact\_location](#input\_artifact\_location) | Location of artifact. Applies only for artifact of type S3 | `string` | `""` | no |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | (Optional) GitHub auth token environment variable (`GITHUB_TOKEN`). Required if enable\_github\_authentication=true | `string` | `""` | no |
| <a name="input_github_token_type"></a> [github\_token\_type](#input\_github\_token\_type) | Storage type of GITHUB\_TOKEN environment variable (`PARAMETER_STORE`, `PLAINTEXT`, `SECRETS_MANAGER`) | `string` | `"SECRETS_MANAGER"` | no |
| <a name="input_enable_github_authentication"></a> [enable\_github\_authentication](#input\_enable\_github\_authentication) | Whether to enable Github authentication using Personal Access token.<br>    If true, it uses the github\_token  and github\_token\_type must be of type SECRETS\_MANAGER to authenticate | `bool` | `false` | no |
| <a name="input_create_webhooks"></a> [create\_webhooks](#input\_create\_webhooks) | Whether to create webhooks for Github, GitHub Enterprise or Bitbucket | `bool` | `false` | no |
| <a name="input_webhook_build_type"></a> [webhook\_build\_type](#input\_webhook\_build\_type) | Webhook build type. Choose between BUILD or BUILD\_BATCH | `string` | `"BUILD"` | no |
| <a name="input_webhook_filters"></a> [webhook\_filters](#input\_webhook\_filters) | Filters supported by webhook. EVENT, BASE\_REF, HEAD\_REF, ACTOR\_ACCOUNT\_ID, FILE\_PATH, COMMIT\_MESSAGE | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to the resources created by the module. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_name"></a> [project\_name](#output\_project\_name) | Project name |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | Project ID |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | IAM Role ID |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | IAM Role ARN |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
