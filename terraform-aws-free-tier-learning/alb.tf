resource "aws_lb" "app" {
  name               = "${local.name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_1.id, aws_subnet.public_2.id]

  tags = {
    Name = "${local.name_prefix}-alb"
  }
}

# Import the existing Application Load Balancer
terraform import aws_lb.app arn:aws:elasticloadbalancing:ap-south-1:614939597046:loadbalancer/app/besant-besant-demo-alb/<alb-id>

# Import the existing Target Group
terraform import aws_lb_target_group.app arn:aws:elasticloadbalancing:ap-south-1:614939597046:targetgroup/besant-besant-demo-target-group/<target-group-id>

# Import the HTTP listener (port 80)
terraform import aws_lb_listener.http arn:aws:elasticloadbalancing:ap-south-1:614939597046:listener/app/besant-besant-demo-alb/<alb-id>/<listener-http-id>

# Import the HTTPS listener (port 443)
terraform import aws_lb_listener.https arn:aws:elasticloadbalancing:ap-south-1:614939597046:listener/app/besant-besant-demo-alb/<alb-id>/<listener-https-id>
