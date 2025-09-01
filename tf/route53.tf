// Hosted zone
data "aws_route53_zone" "portfolio_site_hosted_zone" {
  name         = var.portfolio_site_domain_name
  private_zone = false
}

// Create record pointing to CloudFront
resource "aws_route53_record" "portfolio_site" {
  zone_id = data.aws_route53_zone.portfolio_site_hosted_zone.zone_id
  name    = var.portfolio_site_domain_name
  type    = "A"

  alias {
    name    = aws_cloudfront_distribution.static_portfolio_site_s3.domain_name
    zone_id = aws_cloudfront_distribution.static_portfolio_site_s3.hosted_zone_id
    // CloudFront is a managed service.
    evaluate_target_health = false
  }
}
