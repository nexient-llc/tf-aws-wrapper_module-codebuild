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

variable "name" {
  description = "Stage action name for the CodeBuild project."
  type        = string
  default     = "build"
}


variable "naming_prefix" {
  description = "Prefix for the provisioned resources."
  type        = string
  default     = "platform"
}

variable "codebuild_iam" {
  description = "Additional IAM actions to add to CodeBuild IAM role."
  type        = string
  default     = null
}

variable "buildspec" {
  type        = string
  default     = ""
  description = "Optional buildspec declaration to use for building the project"
}


variable "source_type" {
  type        = string
  default     = "CODEPIPELINE"
  description = "The type of repository that contains the source code to be built. Valid values for this parameter are: CODECOMMIT, CODEPIPELINE, GITHUB, GITHUB_ENTERPRISE, BITBUCKET or S3"
}

variable "source_location" {
  type        = string
  default     = ""
  description = "The location of the source code from git or s3"
}

variable "artifact_type" {
  type        = string
  default     = "CODEPIPELINE"
  description = "The build output artifact's type. Valid values for this parameter are: CODEPIPELINE, NO_ARTIFACTS or S3"
}

variable "artifact_location" {
  type        = string
  default     = ""
  description = "Location of artifact. Applies only for artifact of type S3"
}

variable "github_token" {
  type        = string
  default     = ""
  description = "(Optional) GitHub auth token environment variable (`GITHUB_TOKEN`). Required if enable_github_authentication=true"
}

variable "github_token_type" {
  type        = string
  default     = "SECRETS_MANAGER"
  description = "Storage type of GITHUB_TOKEN environment variable (`PARAMETER_STORE`, `PLAINTEXT`, `SECRETS_MANAGER`)"
}

variable "enable_github_authentication" {
  description = <<EOF
    Whether to enable Github authentication using Personal Access token.
    If true, it uses the github_token  and github_token_type must be of type SECRETS_MANAGER to authenticate
  EOF
  type        = bool
  default     = false
}

variable "create_webhooks" {
  description = "Whether to create webhooks for Github, GitHub Enterprise or Bitbucket"
  type        = bool
  default     = false
}

variable "webhook_build_type" {
  description = "Webhook build type. Choose between BUILD or BUILD_BATCH"
  type        = string
  default     = "BUILD"
}

variable "webhook_filters" {
  description = "Filters supported by webhook. EVENT, BASE_REF, HEAD_REF, ACTOR_ACCOUNT_ID, FILE_PATH, COMMIT_MESSAGE"
  type        = map(string)
  default     = {}
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to the resources created by the module."
}
