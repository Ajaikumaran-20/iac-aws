resource "aws_cloudfront_distribution" "main" {
  enabled = true

  # Custom domain / free subdomain
  aliases = [
    "my-terraform.crabdance.com"
  ]

  # ALB as CloudFront origin
  origin {
    domain_name = aws_lb.app.dns_name
    origin_id   = "alb-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443

      # CloudFront -> ALB using HTTP
      origin_protocol_policy = "http-only"

      origin_ssl_protocols = [
        "TLSv1.2"
      ]
    }
  }

  default_cache_behavior {
    target_origin_id = "alb-origin"

    # Browser -> CloudFront will use HTTPS
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = [
      "GET",
      "HEAD",
      "OPTIONS",
      "PUT",
      "POST",
      "PATCH",
      "DELETE"
    ]

    cached_methods = [
      "GET",
      "HEAD"
    ]

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }

    # Disable caching for learning/testing
    min_ttl     = 0
    default_ttl = 0
    max_ttl     = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # ACM certificate manually created in us-east-1
  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:ap-south-1:614939597046:certificate/bf988ade-2934-4212-bf40-e065f210ba5e"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}