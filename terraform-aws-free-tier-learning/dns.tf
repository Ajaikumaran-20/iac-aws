resource "cloudflare_record" "www" {
  count   = var.dns_provider == "cloudflare" ? 1 : 0

  zone_id = var.cloudflare_zone_id
  name    = "www"
  type    = "CNAME"
  value   = aws_cloudfront_distribution.main.domain_name
  ttl     = 3600
  proxied = true   # keep proxy ON so Cloudflare CDN + SSL works
}
