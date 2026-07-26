resource "aws_lb_target_group" "app" {
  name     = "${local.name_prefix}-target-group"
  port     = 80
  protocol = "HTTP"

  vpc_id = aws_vpc.main.id

  target_type = "instance"

  health_check {
    enabled = true

    protocol = "HTTP"

    port = "traffic-port"

    path = "/"

    matcher = "200-399"

    interval = 30

    timeout = 5

    healthy_threshold = 2

    unhealthy_threshold = 2
  }

  tags = {
    Name = "${local.name_prefix}-target-group"
  }
}