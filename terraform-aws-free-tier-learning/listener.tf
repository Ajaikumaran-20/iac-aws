resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.app.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"

  # Remove ACM reference since Cloudflare handles SSL
  # certificate_arn   = aws_acm_certificate.alb.arn
  # depends_on        = [aws_acm_certificate_validation.alb]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
