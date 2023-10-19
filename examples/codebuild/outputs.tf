// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

output "project_name" {
  description = "Project name"
  value       = module.codebuild.project_name
}

output "project_id" {
  description = "Project ID"
  value       = module.codebuild.project_id
}

output "role_id" {
  description = "IAM Role ID"
  value       = module.codebuild.role_id
}

output "role_arn" {
  description = "IAM Role ARN"
  value       = module.codebuild.role_arn
}

### TF Module Resource outputs
output "naming_prefix" {
  description = "Prefix for the provisioned resources."
  value       = var.naming_prefix
}

output "environment" {
  description = "Environment in which the resource should be provisioned like dev, qa, prod etc."
  value       = var.environment
}

output "environment_number" {
  description = "The environment count for the respective environment. Defaults to 000. Increments in value of 1"
  value       = var.environment_number
}

output "region" {
  description = "AWS Region in which the infra needs to be provisioned"
  value       = replace(var.region, "-", "")
}

output "resource_number" {
  description = "The resource count for the respective resource. Defaults to 000. Increments in value of 1"
  value       = var.resource_number
}


output "resource_name" {
  description = "A map of key to resource_name that will be used by cloudposse/label/null module to generate resource names"
  value       = var.resource_names_map["codebuild"]["name"]
}

#code pipeline

output "codepipeline_name" {
  description = "Code Pipeline Name"
  value       = module.codepipeline.id
}
