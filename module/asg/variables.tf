variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
  default     = "localstack-asg"
}

variable "min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Auto Scaling Group"
  type        = list(string)
  default     = ["subnet-12345678"]
}

variable "security_group_id" {
  description = "Security group ID for the Auto Scaling Group"
  type        = list(string)
   default     = ["sg-12345678"] # Replace with your security group ID

}