resource "cloudflare_record" "www" {
  count = var.dns_provider == "cloudflare" ? 1 : 0

  zone_id = var.cloudflare_zone_id
  name    = "@"
  type    = "CNAME"
  content = aws_cloudfront_distribution.main.domain_name
  ttl     = 1
  proxied = true
}
