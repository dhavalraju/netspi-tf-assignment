# Creating IAM Assume Role with service EC2
resource "aws_iam_role" "s3_iam_role" {
  name               = "s3_iam_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
  EOF
}



# Creating IAM policy with read and write access
resource "aws_iam_policy" "bucket_policy" {
  name        = "bucket_policy"
  description = "Allow"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "s3:ListBucket"
        ],
        "Effect" : "Allow",
        "Resource" : "${aws_s3_bucket.private.arn}"
      },
      {
        "Action" : [
          "s3:GetObject",
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        "Effect" : "Allow",
        "Resource" : "${aws_s3_bucket.private.arn}/*"
      }
    ]
  })
}

# Attaching policy with IAM role
resource "aws_iam_role_policy_attachment" "attach_bucket_policy" {
  role       = aws_iam_role.s3_iam_role.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}

# Creating profile
resource "aws_iam_instance_profile" "profile" {
  name = var.component
  role = aws_iam_role.s3_iam_role.name
}