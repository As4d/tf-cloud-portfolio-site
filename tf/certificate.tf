resource "aws_acm_certificate" "portfolio_site_cert" {
  domain_name       = var.portfolio_site_domain_name
  provider          = aws.us_east_1
  validation_method = "DNS"
}
