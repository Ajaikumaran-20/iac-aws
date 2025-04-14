provider "aws" {
  region = var.region

  endpoints {
    autoscaling = "http://localhost:4566"
    ec2         = "http://localhost:4566"
  }

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

}

resource "aws_launch_configuration" "asg_lc" {
  name            = "${var.asg_name}-lc"
  image_id        = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI ID
  instance_type   = var.instance_type
  security_groups = var.security_group_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = var.asg_name
  launch_configuration      = aws_launch_configuration.asg_lc.id
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = var.subnet_ids
  health_check_type         = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = var.asg_name
    propagate_at_launch = true
  }
}