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
| <a name="input_codebuild_projects"></a> [codebuild\_projects](#input\_codebuild\_projects) | List of CodeBuild projects to create. | `any` | `[]` | no |
| <a name="input_naming_prefix"></a> [naming\_prefix](#input\_naming\_prefix) | Prefix for the provisioned resources. | `string` | `"platform"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. | `string` | `"dev"` | no |
| <a name="input_environment_number"></a> [environment\_number](#input\_environment\_number) | The environment count for the respective environment. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region in which the infra needs to be provisioned | `string` | `"us-east-2"` | no |
| <a name="input_resource_number"></a> [resource\_number](#input\_resource\_number) | The resource count for the respective resource. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by cloudposse/label/null module to generate resource names | `map(string)` | <pre>{<br>  "codebuild": "cb",<br>  "iam_policy": "iamp",<br>  "iam_role": "iamr"<br>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to the resources created by the module. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_name"></a> [project\_name](#output\_project\_name) | Project name |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | Project ID |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | IAM Role ID |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | IAM Role ARN |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
