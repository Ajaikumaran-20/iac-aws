# Terraform AWS Free Tier Learning Project

This project is created strictly for learning and hands-on practice using an AWS Free Tier account. It is not a production-ready architecture.

## 1. Project Purpose

This repository provides a simple, beginner-friendly AWS architecture that demonstrates:

- VPC, subnets, route tables, and Internet Gateway
- Route 53 DNS
- ACM certificates
- CloudFront CDN
- Internet-facing ALB
- Target Group
- Launch Template
- Auto Scaling Group
- Private EC2 instance
- Terraform IaC

This README is written as an explanation-focused guide for learning how the complete path works in AWS.

The main learning objective is the full request flow:

Internet User → Route 53 → CloudFront → ALB → Target Group → ASG → Private EC2 → Application

## 2. Reference Architecture

The architecture is based on the requested reference screenshot, while following actual AWS technical requirements. The screenshot shows the intended conceptual layout, but the final Terraform implementation uses AWS-valid practices.

## 3. Architecture Diagram

```text
Internet User
    |
    | HTTPS
    v
Route 53
    |
    | DNS Alias
    v
CloudFront CDN
    |
    | HTTPS
    v
Internet-Facing ALB
    |
    | HTTPS
    v
Target Group
    |
    | Application Port
    v
Private Subnet
    |
    v
Auto Scaling Group
    |
    v
Private EC2
    |
    v
Application
```

## 4. Architecture Differences from Screenshot

The screenshot is used as the conceptual starting point, but the final Terraform implementation must follow real AWS constraints.

Key differences:

1. The ALB must be placed in at least two public subnets across two Availability Zones.
2. The EC2/ASG placement is one private subnet in one Availability Zone.
3. CloudFront custom certificates must be created in us-east-1.
4. The ALB certificate must be created in the application region.
5. NAT Gateway is intentionally not created by default to keep the learning project cost-conscious.
6. This is not production-grade high availability.

## 5. Single-AZ vs ALB Two-AZ Requirement

A single-AZ design is the easiest learning model, but AWS ALB has a hard requirement that it must be created in at least two subnets in different Availability Zones.

Therefore, the implementation uses:

- 2 public subnets in 2 AZs for the ALB
- 1 private subnet in 1 AZ for EC2/ASG

This remains a learning-friendly design, not a production HA design.

## 6. AWS Components

- VPC
- Public Subnets
- Private Subnet
- Internet Gateway
- Public Route Table
- Private Route Table
- Security Groups
- ALB
- Target Group
- Launch Template
- Auto Scaling Group
- EC2
- Route 53 Hosted Zone
- ACM Certificates
- CloudFront

## 7. Why Each Component Is Used

- VPC: network boundary for the architecture.
- Public subnet: used for internet-facing ALB networking.
- Private subnet: used for private EC2/ASG instances.
- Internet Gateway: allows traffic from the public internet into the VPC public subnets.
- Route table: determines how traffic is routed.
- Security groups: control allowed inbound and outbound traffic.
- ALB: entry point for internet traffic.
- Target group: receives traffic from ALB and routes to EC2.
- Launch Template: defines EC2 instance details.
- ASG: maintains EC2 capacity according to the desired configuration.
- Route 53: DNS service used for the hostname.
- ACM: provides HTTPS certificates.
- CloudFront: caches and accelerates content delivery.

## 8. Public vs Private Subnet

- Public subnets are used for internet-facing resources like the ALB.
- Private subnets are used for instances that should not be directly exposed to the public internet.
- The EC2 instance is private because the architecture wants the application behind the ALB rather than directly exposed.

## 9. VPC

A VPC provides an isolated virtual network boundary for your resources. In this project, all application components live inside one VPC.

## 10. Route Tables

A route table controls where network traffic goes.

- Public route table: sends 0.0.0.0/0 to the Internet Gateway.
- Private route table: no default route to the Internet Gateway.

This keeps the private subnet isolated from direct public internet routing.

## 11. Internet Gateway

The Internet Gateway provides internet access for resources in the public subnets. It is required for the ALB to receive inbound internet traffic.

## 12. Route 53

Route 53 is AWS DNS.

The project creates a hosted zone for the given domain and an alias record:

- www.example.com → CloudFront

This makes the application available at:

https://www.<domain-name>

## 13. DNS

DNS resolves a human-friendly domain name to an IP or a service endpoint. In this architecture, Route 53 is used to point the www record to the CloudFront distribution.

## 14. ACM

ACM is used for TLS certificates.

This project uses two certificates:

1. CloudFront ACM certificate in us-east-1
2. ALB ACM certificate in the application region

CloudFront custom HTTPS certificates must be created in us-east-1, so a separate AWS provider alias is required for that purpose.

## 15. CloudFront

CloudFront is a CDN service that sits in front of the ALB and improves content caching and delivery.

The flow is:

User → CloudFront → ALB → Target Group → EC2

CloudFront is placed before ALB to provide improved caching, edge delivery, and HTTPS termination behavior.

Important learning note:

- This project uses CloudFront in IPv4-only mode.
- That means the distribution is configured with `is_ipv6_enabled = false`.
- This keeps the architecture simple and aligned with the current learning requirement.

## 16. ALB

The ALB is internet-facing and uses the two public subnets.

It receives traffic from CloudFront, then distributes it to the target group. The target group forwards to the EC2 instance in the private subnet.

## 17. Target Group

The ALB routes traffic to the target group. The target group performs health checks and sends traffic only to healthy instances.

## 18. Security Groups

Two security groups are created:

- ALB security group: allows inbound HTTP/HTTPS from the internet.
- EC2 security group: allows only application traffic from the ALB security group.

This design keeps the EC2 instance private and limits the attack surface.

## 19. Launch Template

The Launch Template defines how the EC2 instance should be created. It contains the AMI ID, instance type, key pair, and security group association.

## 20. Auto Scaling Group

The ASG uses the Launch Template and places instances in the private subnet. It registers instances with the ALB target group and replaces unhealthy instances.

This project keeps ASG at minimum size 1, desired 1, and maximum 1 for learning simplicity.

## 21. EC2

The EC2 instance is private and only reachable through the ALB and allowed security group rules.

## 22. NAT Gateway

A NAT Gateway is not created by default.

Why not:

- Learning project
- Avoid unnecessary costs
- No Internet package downloads in user data
- Private EC2 is not directly exposed to the public internet

If AWS internet access is needed for EC2, alternatives include:

- pre-baked AMI with required software already installed
- NAT Gateway only when explicitly required
- VPC endpoints for AWS service access

## 23. Free Tier Cost Considerations

This project is intentionally cost-conscious, but AWS Free Tier eligibility depends on multiple factors:

- Account creation date
- AWS Region
- Account type
- Current AWS Free Tier policies
- Current AWS pricing

Potential costs may include:

- EC2
- EBS
- ALB
- CloudFront
- Route 53 hosted zone / records
- Public IPv4 addresses
- Data transfer
- NAT Gateway if enabled later

## 24. Deployment

1. Configure AWS authentication so Terraform can assume the provided IAM role.
2. Copy terraform.tfvars.example to terraform.tfvars.
3. Fill in all required values.
4. Run:

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

5. Wait for:

- ACM validation
- CloudFront deployment
- ALB creation
- EC2 launch
- Target group health checks

6. Test the URL:

```text
https://www.<your-domain>
```

## 25. Validation

Verify the following after deployment:

- Route 53 DNS
- ACM certificates
- CloudFront distribution
- VPC and subnets
- Route tables
- Internet Gateway
- ALB
- Target group
- EC2 instance
- ASG
- Security groups
- Application URL

## 26. Troubleshooting

Common troubleshooting items include:

- ACM certificate pending validation
- Route 53 DNS not resolving
- CloudFront deployment issues
- CloudFront 502 error
- ALB target unhealthy
- ALB cannot reach EC2
- EC2 application not running
- Security group issue
- Route table issue
- Incorrect health check path
- SSH failure
- ALB access failure
- Private subnet connectivity issue

## 27. Cleanup

Destroy all resources after learning/testing:

```bash
terraform destroy -var-file="terraform.tfvars"
```

Then verify that CloudFront, Route 53, ACM, ALB, target group, ASG, EC2, EBS, security groups, VPC, subnets, route tables, and Internet Gateway are removed.
