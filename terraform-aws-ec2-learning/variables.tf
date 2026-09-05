variable "aws_region" {
  description = "AWS Region for the EC2 instance."
  type        = string
}

variable "client" {
  description = "Client short name used in the naming convention."
  type        = string
}

variable "group" {
  description = "Group or project name used in the naming convention."
  type        = string
}

variable "environment" {
  description = "Environment name used in the naming convention."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for the VPC."
  type        = string
  default     = "10.10.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR for the public subnet."
  type        = string
  default     = "10.10.1.0/24"
}

variable "availability_zone" {
  description = "Availability Zone for the public subnet."
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Existing EC2 key pair name. Leave empty if SSH is not required."
  type        = string
  default     = ""
}

variable "ssh_allowed_cidrs" {
  description = "CIDRs allowed to SSH into the instance."
  type        = list(string)
  default     = []
}

variable "application_port" {
  description = "TCP port exposed by the instance."
  type        = number
  default     = 80
}
