

resource "aws_acm_certificate" "cloudfront" {
  provider = aws.us_east_1

  domain_name       = "www.terraform.dev"
  validation_method = "EMAIL"

  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_acm_certificate_validation" "cloudfront" {
#   provider = aws.us_east_1

#   certificate_arn = aws_acm_certificate.cloudfront.arn

#   validation_record_fqdns = [
#     for record in cloudflare_record.cloudfront_validation :
#     record.hostname
#   ]

#   depends_on = [
#     cloudflare_record.cloudfront_validation
#   ]
# }