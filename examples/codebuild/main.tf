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

module "codepipeline" {
  source = "git::https://github.com/nexient-llc/tf-aws-module-codepipeline?ref=0.1.0"

  name = var.naming_prefix

  create_s3_source = var.create_s3_source
  source_s3_bucket = var.source_s3_bucket
  stages = [
    {
      stage_name = "Source"
      name       = "Source"
      category   = "Source"
      owner      = "AWS"
      provider   = "S3"
      version    = "1"
      configuration = {
        S3Bucket             = "ntt-codepipeline-codebuild-test-01"
        S3ObjectKey          = "trigger/codebuild-sample-app.zip"
        PollForSourceChanges = "false"
      }
      input_artifacts  = []
      output_artifacts = ["SourceArtifact"]
      run_order        = null
      region           = null
      namespace        = null
    },
    {
      stage_name = "Build"
      name       = "Build"
      category   = "Build"
      owner      = "AWS"
      provider   = "CodeBuild"
      version    = "1"
      configuration = {
        ProjectName = module.codebuild.project_name[0]
      }
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      run_order        = null
      region           = null
      namespace        = null
    }
  ]

  tags = var.tags
}

module "codebuild" {
  source = "../.."

  codebuild_projects = var.codebuild_projects
  naming_prefix      = var.naming_prefix
  region             = var.region
  environment        = var.environment
  environment_number = var.environment_number
  resource_number    = var.resource_number
  resource_names_map = var.resource_names_map
  extra_permissions  = var.extra_permissions

  tags       = var.tags
  depends_on = [aws_s3_object.sample_app]
}

# resource "aws_s3_bucket" "sample_app" {
#   bucket = var.source_s3_bucket
#   tags   = var.tags
# }

resource "aws_s3_object" "sample_app" {
  bucket = var.source_s3_bucket
  key    = "trigger/codebuild-sample-app.zip"
  source = "codebuild-sample-app.zip"
  tags   = var.tags
}
