resource "aws_cloudfront_distribution" "main" {
  enabled         = true
  is_ipv6_enabled = false
  price_class     = var.cloudfront_price_class
  comment         = "${local.name_prefix}-cloudfront"

  origin {
    domain_name = aws_lb.app.dns_name
    origin_id   = "alb-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "alb-origin"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Remove ACM reference since Cloudflare handles SSL
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  aliases = [local.www_fqdn]

  tags = {
    Name = "${local.name_prefix}-cloudfront"
  }
}
