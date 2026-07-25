output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_2.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "availability_zones" {
  value = [var.availability_zone, var.second_availability_zone]
}

output "alb_dns_name" {
  value = aws_lb.app.dns_name
}

output "alb_arn" {
  value = aws_lb.app.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.app.arn
}

output "asg_name" {
  value = aws_autoscaling_group.app.name
}

output "launch_template_id" {
  value = aws_launch_template.app.id
}

output "alb_security_group_id" {
  value = aws_security_group.alb_sg.id
}

output "ec2_security_group_id" {
  value = aws_security_group.ec2_sg.id
}

output "route53_hosted_zone_id" {
  value = ""
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.main.id
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.main.domain_name
}

output "cloudfront_acm_certificate_arn" {
  value = aws_acm_certificate.cloudfront.arn
}

output "alb_acm_certificate_arn" {
  value = aws_acm_certificate.alb.arn
}

output "application_url" {
  value = var.dns_provider == "cloudflare" ? "https://${aws_cloudfront_distribution.main.domain_name}" : local.app_url
}
