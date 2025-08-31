variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-2"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name"
  default     = "asad-ali-khan-static-portfolio-site"
}

variable "portfolio_site_domain_name" {
  type        = string
  description = "Domain for portfolio site"
  default     = "asadalikhan.co.uk"
}
