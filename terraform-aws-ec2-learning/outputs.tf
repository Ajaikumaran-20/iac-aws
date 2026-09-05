output "instance_id" {
  value = aws_instance.standalone.id
}

output "instance_public_ip" {
  value = aws_instance.standalone.public_ip
}

output "instance_public_dns" {
  value = aws_instance.standalone.public_dns
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.public.id
}

output "security_group_id" {
  value = aws_security_group.ec2.id
}
