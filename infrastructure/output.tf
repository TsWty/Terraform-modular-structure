output "ec2_public_ip" {
  description = "EC2 instance'ın public IP adresi"
  value       = module.ec2.public_ip
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = module.vpc.subnet_id
}