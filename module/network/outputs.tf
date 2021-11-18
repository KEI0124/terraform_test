output "vpc_id" {
    value = module.vpc.vpc_id
}

output "public_subnet_ids" {
    value = module.subnet_public.subnet_ids
}

output "private_subnet_ids" {
    value = module.subnet_private.subnet_ids
}

output "private_subnet_ids_rds" {
    value = module.subnet_private_rds.subnet_ids
}