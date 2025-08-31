// Create bucket
resource "aws_s3_bucket" "static_portfolio_site" {
  bucket = var.bucket_name
}





// build a bucket policy that allows cloudfront to read the bucket content only
data "aws_iam_policy_document" "allow_cloudfront_service_principal_readonly" {
  statement {
    sid    = "AllowCloudFrontServicePrincipalReadOnly"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.static_portfolio_site.arn,
      "${aws_s3_bucket.static_portfolio_site.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = ["${aws_cloudfront_distribution.static_portfolio_site_s3.arn}"]
    }
  }
}

// Add a bucket policy 
resource "aws_s3_bucket_policy" "allow_cloudfront_service_principal_readonly" {
  bucket = aws_s3_bucket.static_portfolio_site.id
  policy = data.aws_iam_policy_document.allow_cloudfront_service_principal_readonly.json
}
