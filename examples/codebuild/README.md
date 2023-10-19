# codebuild

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_codepipeline"></a> [codepipeline](#module\_codepipeline) | git::https://github.com/nexient-llc/tf-aws-module-codepipeline | 0.1.0 |
| <a name="module_codebuild"></a> [codebuild](#module\_codebuild) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_object.sample_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_codebuild_projects"></a> [codebuild\_projects](#input\_codebuild\_projects) | List of CodeBuild projects to create. | `any` | `[]` | no |
| <a name="input_naming_prefix"></a> [naming\_prefix](#input\_naming\_prefix) | Prefix for the provisioned resources. | `string` | `"platform"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. | `string` | `"dev"` | no |
| <a name="input_environment_number"></a> [environment\_number](#input\_environment\_number) | The environment count for the respective environment. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region in which the infra needs to be provisioned | `string` | `"us-east-1"` | no |
| <a name="input_resource_number"></a> [resource\_number](#input\_resource\_number) | The resource count for the respective resource. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-module-resource\_name to generate resource names | <pre>map(object(<br>    {<br>      name       = string<br>      max_length = optional(number, 30)<br>    }<br>  ))</pre> | <pre>{<br>  "codebuild": {<br>    "max_length": 30,<br>    "name": "cb"<br>  }<br>}</pre> | no |
| <a name="input_extra_permissions"></a> [extra\_permissions](#input\_extra\_permissions) | List of action strings which will be added to IAM service account permissions. | `list(any)` | `[]` | no |
| <a name="input_create_s3_source"></a> [create\_s3\_source](#input\_create\_s3\_source) | Create S3 source bucket for CodePipeline. | `string` | `false` | no |
| <a name="input_source_s3_bucket"></a> [source\_s3\_bucket](#input\_source\_s3\_bucket) | Name of the S3 source bucket. | `string` | `null` | no |
| <a name="input_stages"></a> [stages](#input\_stages) | One or more stage blocks. | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to the resources created by the module. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_name"></a> [project\_name](#output\_project\_name) | Project name |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | Project ID |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | IAM Role ID |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | IAM Role ARN |
| <a name="output_naming_prefix"></a> [naming\_prefix](#output\_naming\_prefix) | Prefix for the provisioned resources. |
| <a name="output_environment"></a> [environment](#output\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. |
| <a name="output_environment_number"></a> [environment\_number](#output\_environment\_number) | The environment count for the respective environment. Defaults to 000. Increments in value of 1 |
| <a name="output_region"></a> [region](#output\_region) | AWS Region in which the infra needs to be provisioned |
| <a name="output_resource_number"></a> [resource\_number](#output\_resource\_number) | The resource count for the respective resource. Defaults to 000. Increments in value of 1 |
| <a name="output_resource_name"></a> [resource\_name](#output\_resource\_name) | A map of key to resource\_name that will be used by cloudposse/label/null module to generate resource names |
| <a name="output_codepipeline_name"></a> [codepipeline\_name](#output\_codepipeline\_name) | Code Pipeline Name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
