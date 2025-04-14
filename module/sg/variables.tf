variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
  default = "vpc-12345678" # Replace with your VPC ID
}

variable "sg_name" {
  description = "Name of the security group"
  type        = string
  default     = "localstack-sg"
}

variable "description" {
  description = "Description for the security group"
  type        = string
  default     = "Security group for LocalStack testing"
}