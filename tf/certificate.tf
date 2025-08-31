resource "aws_acm_certificate" "portfolio_site_cert" {
  domain_name = var.portfolio_site_domain_name
  region      = "us-east-1"
}
