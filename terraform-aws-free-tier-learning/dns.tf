# resource "cloudflare_record" "www" {
#   zone_id = var.cloudflare_zone_id

#   name    = "www"
#   type    = "CNAME"
#   content = aws_cloudfront_distribution.main.domain_name

#   ttl     = 1
#   proxied = true
# }