resource "aws_launch_template" "app" {
  name_prefix   = "${local.name_prefix}-launch-template-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  key_name = var.key_pair_name != "" ? var.key_pair_name : null

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${local.name_prefix}-ec2"
    }
  }
}
