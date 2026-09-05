# Standalone EC2 Learning Project

This folder creates one standalone EC2 instance in a new public VPC. It is separate from the ALB and Auto Scaling architecture in `terraform-aws-free-tier-learning`.

Terraform state is stored in the shared S3 bucket under the separate key `terraform/ec2/state.tfstate`.

## Usage

1. Copy `terraform.tfvars.example` to `terraform.tfvars`.
2. Set a valid AMI ID for the selected AWS region.
3. Replace `YOUR_PUBLIC_IP/32` with your public IP, or leave `ssh_allowed_cidrs` empty to disable SSH.
4. Run:

```powershell
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

The instance public IP and DNS name are returned as Terraform outputs.

## GitHub Actions

The `.github/workflows/terraform-ec2.yml` workflow runs from this folder. Pushes and pull requests run validation and a plan. Use **Run workflow** to select `apply`, `destroy-plan`, or `destroy`.

The workflow uses GitHub OIDC with the existing `terraform-role`, and the `demo` GitHub Environment must be configured for that role and branch protection.

Destroy the resources when finished to avoid AWS charges:

```powershell
terraform destroy
```
