
extra_permissions   = ["s3:*"]
codebuild_s3_bucket = "ntt-codepipeline-codebuild-test-01"
codebuild_projects = [
  {
    name              = "deploy"
    buildspec         = "buildspec.yml"
    source_type       = "S3"
    source_location   = "ntt-codepipeline-codebuild-test-01/trigger/codebuild-sample-app.zip"
    artifact_type     = "S3"
    artifact_location = "ntt-codepipeline-codebuild-test-01"
    codebuild_iam = {
      actions = [
        "sts:AssumeRole"
      ]
      resources = [
        "arn:aws:iam::12345678:role/testrole"
      ]
    }
  }
]


# code pipeline
name             = "codebuild-test-pipeline"
create_s3_source = true
source_s3_bucket = "ntt-codepipeline-codebuild-test-01"

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
      ProjectName = "test"
    }
    input_artifacts  = ["SourceArtifact"]
    output_artifacts = ["BuildArtifact"]
    run_order        = null
    region           = null
    namespace        = null
  }
]
