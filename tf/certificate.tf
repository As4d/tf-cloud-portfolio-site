resource "aws_acm_certificate" "portfolio_site_cert" {
  domain_name = "asadalikhan.com"
  region      = "us-east-1"
}
