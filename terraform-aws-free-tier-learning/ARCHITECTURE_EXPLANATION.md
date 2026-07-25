# AWS Architecture Explanation

This document explains the architecture in simple, beginner-friendly language.

## 1. Purpose

This project is a learning-only AWS architecture built for hands-on practice using a Free Tier account. It is intentionally simple and cost-conscious.

## 2. End-to-End Traffic Flow

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
Internet-facing ALB
    |
    | HTTPS
    v
Target Group
    |
    | Application Port
    v
Auto Scaling Group
    |
    v
Private EC2
    |
    v
Application

## 3. What Each Component Does

### User
A browser or client sends a request.

### Route 53
Route 53 is AWS DNS. It converts the domain name such as `www.example.com` into the correct AWS service endpoint.

### CloudFront
CloudFront is the CDN layer. It receives the request first and provides edge delivery, caching, and HTTPS handling.

### ACM
ACM provides HTTPS certificates.

- CloudFront certificate is created in `us-east-1`
- ALB certificate is created in the application AWS region

### Internet-facing ALB
The ALB is the public entry point for the application. It receives requests from CloudFront and forwards them to the target group.

### Target Group
The target group is the set of backend instances that the ALB can send traffic to.

### Auto Scaling Group
The ASG uses the Launch Template and keeps one EC2 instance in the private subnet for this learning setup.

### Private EC2
The EC2 instance is not directly exposed to the internet. It is only reachable through the ALB and the EC2 security group.

## 4. Why This Design Is Used

This design teaches the following AWS concepts clearly:

- DNS with Route 53
- HTTPS using ACM
- CDN with CloudFront
- Load balancing with ALB
- Backend registration through Target Group
- Private EC2 hosting behind the ALB
- Infrastructure creation using Terraform

## 5. Public vs Private Subnet

### Public Subnet
Used for internet-facing resources like the ALB.

### Private Subnet
Used for the backend EC2 instance so it is not directly exposed to the internet.

## 6. Why ALB Needs Two Public Subnets

AWS ALB must be created in at least two subnets in different Availability Zones.

So the architecture uses:

- Public Subnet 1 in AZ-1
- Public Subnet 2 in AZ-2

The ALB uses both public subnets.

## 7. Why Only One Private Subnet Is Used

To keep the project simple and beginner-friendly, the backend is placed in one private subnet only.

This is not production-grade high availability, because:

- the EC2 is inside one AZ only
- if that AZ fails, the application can be affected
- the ASG is set to minimum 1, desired 1, maximum 1

## 8. Security Model

### ALB Security Group
Allows:
- HTTP 80 from the internet
- HTTPS 443 from the internet

### EC2 Security Group
Allows traffic only from the ALB security group to the application port.

This means the EC2 instance is protected and not directly reachable from the internet.

## 9. NAT Gateway

A NAT Gateway is not created by default.

Why:

- to keep costs low
- to avoid unnecessary complexity
- to stay focused on learning AWS networking basics

Private EC2 in this project does not need outbound internet access for the lab flow.

## 10. IPv4-Only Note

This project uses CloudFront in IPv4-only mode.

That means:

- IPv6 is disabled for the CloudFront distribution
- the architecture is kept intentionally simple

## 11. Important Note About Free Tier

AWS Free Tier eligibility depends on:

- account creation date
- region
- account type
- current AWS pricing rules
- current AWS Free Tier policies

So this project is designed to be cost-conscious, but it is not guaranteed to be free in every account and region.

## 12. Summary

This architecture is a beginner-friendly AWS learning flow:

User → Route 53 → CloudFront → ALB → Target Group → ASG → Private EC2 → Application

It shows the basic network, DNS, HTTPS, CDN, load balancing, and private EC2 flow in a very simple, teachable format.
