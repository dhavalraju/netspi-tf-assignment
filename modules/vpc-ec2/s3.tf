resource "aws_s3_bucket" "private" {
  bucket = var.bucket_name
  acl    = "private"
  tags = {
    Name = "${var.component}-bucket"
  }
}

