resource "aws_security_group" "alb_sg" {
  name        = "${local.name_prefix}-alb-sg"
  description = "Security group for internet-facing Application Load Balancer"
  vpc_id      = aws_vpc.main.id

  # Allow HTTP from the internet
  ingress {
    description = "Allow HTTP from Internet"

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS from the internet
  ingress {
    description = "Allow HTTPS from Internet"

    from_port   = 443
    to_port     = 443
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  # ALB can send traffic to targets
  egress {
    description = "Allow outbound traffic"

    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.name_prefix}-alb-sg"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "${local.name_prefix}-ec2-sg"
  description = "Security group for private EC2 instances behind ALB"
  vpc_id      = aws_vpc.main.id

  # Allow application traffic ONLY from ALB
  ingress {
    description = "Allow application traffic from ALB"

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    security_groups = [
      aws_security_group.alb_sg.id
    ]
  }

  # Optional SSH access
  # Only enabled when key_pair_name and ssh_allowed_cidrs are configured
  dynamic "ingress" {
    for_each = (
      var.key_pair_name != "" &&
      length(var.ssh_allowed_cidrs) > 0
    ) ? var.ssh_allowed_cidrs : []

    content {
      description = "SSH access"

      from_port   = 22
      to_port     = 22
      protocol    = "tcp"

      cidr_blocks = [
        ingress.value
      ]
    }
  }

  # Allow outbound traffic
  egress {
    description = "Allow outbound traffic"

    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.name_prefix}-ec2-sg"
  }
}