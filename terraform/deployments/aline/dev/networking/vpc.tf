module "vpc" {
    source = "../../modules/vpc"
    vpc_cidr_block = var.vpc_cidr_block
    public_subnet_numbers = var.public_subnet_numbers
    private_subnet_numbers = var.private_subnet_numbers
    infra_env = var.infra_env
}
