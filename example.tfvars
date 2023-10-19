# Replace the <> with the actual values
codebuild_projects = [
  {
    name          = "deploy"
    buildspec     = "buildspec.yml"
    codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["ec2:Describe*"],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
  },
  {
    name      = "auto_qa"
    buildspec = "buildspec.yml"
  }
]
