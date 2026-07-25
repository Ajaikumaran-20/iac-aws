resource "cloudflare_record" "cloudfront_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cloudfront.domain_validation_options :
    dvo.domain_name => dvo
  }

  zone_id = var.cloudflare_zone_id

  # ACM gives:
  # _260e9ae0feaef7a8058c97e2a19138e9.www.terraform.dev.
  #
  # Cloudflare zone is:
  # terraform.dev
  #
  # Therefore record name must be:
  # _260e9ae0feaef7a8058c97e2a19138e9.www

  name = replace(
    trimsuffix(each.value.resource_record_name, "."),
    ".terraform.dev",
    ""
  )

  type    = each.value.resource_record_type
  content = each.value.resource_record_value

  ttl     = 60
  proxied = false
}

resource "cloudflare_record" "www" {
  zone_id = var.cloudflare_zone_id

  name    = "www"
  type    = "CNAME"
  content = aws_cloudfront_distribution.main.domain_name

  ttl     = 1
  proxied = true
}