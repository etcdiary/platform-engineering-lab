output "vpc_id" {
  description = "Sandbox VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Sandbox public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Sandbox private subnet IDs"
  value       = module.vpc.private_subnet_ids
}