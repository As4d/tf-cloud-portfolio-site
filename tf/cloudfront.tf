// Create an origin access control (OAC) for the S3 bucket so that cloudfront can access the bucket
resource "aws_cloudfront_origin_access_control" "static_portfolio_site_s3" {
  name                              = "static_portfolio_site_s3"
  description                       = "Static Portfolio Site S3 Origin Access Control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

// Create a local variable for the origin ID (unique identifier for the origin.)
locals {
  origin_id = "S3-${aws_s3_bucket.static_portfolio_site.bucket}"
}

// Create a cloudfront distribution for the S3 bucket
resource "aws_cloudfront_distribution" "static_portfolio_site_s3" {

  origin {
    domain_name              = aws_s3_bucket.static_portfolio_site.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.static_portfolio_site_s3.id
    origin_id                = local.origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Static Portfolio Site S3 Distribution"
  default_root_object = "index.html"

  default_cache_behavior {
    // Using the CachingOptimized managed policy ID
    // https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html#managed-cache-caching-optimized 
    cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.origin_id

    viewer_protocol_policy = "allow-all"
    compress               = true
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.portfolio_site_cert.arn
  }

  tags = {
    Name = "Static Portfolio Site S3 Distribution"
  }
}
