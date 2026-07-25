resource "cloudflare_record" "cloudfront_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cloudfront.domain_validation_options :
    dvo.domain_name => {
      name  = dvo.resource_record_name
      value = dvo.resource_record_value
      type  = dvo.resource_record_type
    }
  }

  zone_id = var.cloudflare_zone_id

  # Remove trailing dot and zone name
  name = replace(
    trimsuffix(each.value.name, "."),
    ".${var.domain_name}",
    ""
  )

  type    = each.value.type
  content = each.value.value

  ttl     = 1
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