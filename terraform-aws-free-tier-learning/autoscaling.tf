resource "aws_autoscaling_group" "app" {
  name                = "${local.name_prefix}-asg"
  min_size            = var.min_size
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  vpc_zone_identifier = [aws_subnet.private_1.id ,aws_subnet.private_2.id]
  target_group_arns   = [aws_lb_target_group.app.arn]
  health_check_type   = "ELB"

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-ec2"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "app" {
  autoscaling_group_name = aws_autoscaling_group.app.name

  lb_target_group_arn = aws_lb_target_group.app.arn
}
