
extra_permissions = ["s3:*"]
codebuild_projects = [
  {
    name          = "plan"
    buildspec     = "buildspec.yml"
    source_type   = "S3"
    codebuild_iam = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "sts:AssumeRole"
        ],
        "Resource": [
          "arn:aws:iam::12345678:role/testrole"
        ]
      }
    ]
}
EOF
  },
  {
    name          = "deploy"
    buildspec     = "buildspec.yml"
    source_type   = "S3"
    codebuild_iam = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "sts:AssumeRole"
        ],
        "Resource": [
          "arn:aws:iam::12345678:role/testrole"
        ]
      }
    ]
}
EOF
  }
]
