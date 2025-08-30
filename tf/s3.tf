// Create bucket
resource "aws_s3_bucket" "static_portfolio_site" {
  bucket = var.bucket_name
}

// Enable static website hosting 
resource "aws_s3_bucket_website_configuration" "static_portfolio_site" {
  bucket = aws_s3_bucket.static_portfolio_site.id

  index_document {
    suffix = "index.html"
  }
}

// Edit Block Public Access settings
resource "aws_s3_bucket_public_access_block" "static_portfolio_site" {
  bucket = aws_s3_bucket.static_portfolio_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

// build a bucket policy that makes your bucket content publicly available
data "aws_iam_policy_document" "grant_public_read_access" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.static_portfolio_site.arn,
      "${aws_s3_bucket.static_portfolio_site.arn}/*",
    ]
  }
}

// Add a bucket policy
resource "aws_s3_bucket_policy" "grant_public_read_access" {
  bucket = aws_s3_bucket.static_portfolio_site.id
  policy = data.aws_iam_policy_document.grant_public_read_access.json
}
