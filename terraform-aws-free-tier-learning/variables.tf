variable "aws_region" {
  description = "AWS Region for application resources."
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID used for naming and references."
  type        = string
}

variable "terraform_role_arn" {
  description = "IAM role ARN used by Terraform to assume the deployment role."
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
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR for public subnet 1."
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR for public subnet 2."
  type        = string
}

variable "private_subnet_1_cidr" {
  description = "CIDR for the private subnet."
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR for the private subnet."
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone for public subnet 1 and private subnet."
  type        = string
}

variable "second_availability_zone" {
  description = "Availability Zone for public subnet 2."
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 launch template."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type. Default is t3.micro for learning use."
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Existing EC2 key pair name. Leave empty if SSH is not required."
  type        = string
  default     = ""
}

variable "min_size" {
  description = "Minimum size for the Auto Scaling Group."
  type        = number
  default     = 1
}

variable "desired_capacity" {
  description = "Desired capacity for the Auto Scaling Group."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size for the Auto Scaling Group."
  type        = number
  default     = 1
}

variable "application_port" {
  description = "Application port exposed by the EC2 instance."
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "Health check path used by the ALB target group."
  type        = string
  default     = "/"
}

variable "ssh_allowed_cidrs" {
  description = "List of CIDRs allowed to SSH into EC2. Leave empty to disable SSH access."
  type        = list(string)
  default     = []
}

variable "domain_name" {
  description = "Root domain name used by ACM and DNS."
  type        = string
}

variable "dns_provider" {
  description = "DNS provider to use for public hostname records. Use 'cloudflare' as the free-tier-friendly alternative."
  type        = string
  default     = "cloudflare"
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token for DNS record management."
  type        = string
  default     = ""
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID for the root domain."
  type        = string
  default     = ""
}

variable "cloudfront_price_class" {
  description = "CloudFront price class."
  type        = string
  default     = "PriceClass_100"
}

variable "application_port" {
  description = "Port used by the application"
  type        = number
  default     = 80
}