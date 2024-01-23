resource "aws_s3_bucket" "bucket-23-jan" {
    bucket = "bucket-23-jan"
  
}
resource "aws_s3_bucket_public_access_block" "bucket-23-jan" {
  bucket = aws_s3_bucket.bucket-23-jan.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_object" "index" {
  bucket = "bucket-23-jan"
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"
}
resource "aws_s3_object" "error" {
  bucket = "bucket-23-jan"
  key    = "error.html"
  source = "error.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "bucket-23-jan" {
  bucket = aws_s3_bucket.bucket-23-jan.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}
resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.bucket-23-jan.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
   "Principal": "*",
      "Action": [ "s3:GetObject" ],
      "Resource": [
        "${aws_s3_bucket.bucket-23-jan.arn}",
        "${aws_s3_bucket.bucket-23-jan.arn}/*"
      ]
    }
  ]
}
EOF
}