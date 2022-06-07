# create VPC in region
resource "aws_vpc" "vpc" {

  cidr_block       = var.vpc_cidr_block 

  instance_tenancy = "default"

  tag = {
    Name = "US_EAST_1_VPC-SF"
    Project = "aline-SF"
    Environment = var.infra-env
    ManagedBy = "terraform"
  }

}

# create 1 public subnet for each AZ within the region VPC is in
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.vpc.id
    for_each = var.public_subnet_numbers
    cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)  # 2,048 IP addresses each off /17
    availability_zone = each.key

  tags = {
    Name        = "aline-${var.infra_env}-public-subnet"
    Project     = "aline-SF"
    Role        = "public"
    Environment = var.infra_env
    ManagedBy   = "terraform"
    Subnet      = "${each.key}-${each.value}"
  }

}

# create 1 private subnet for each AZ within the region VPC is in
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.vpc.id
    for_each = var.private_subnet_numbers
    cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)  # 2,048 IP addresses each off /17
    availability_zone = each.key

  tags = {
    Name        = "aline-${var.infra_env}-private-subnet"
    Project     = "aline-SF"
    Role        = "private"
    Environment = var.infra_env
    ManagedBy   = "terraform"
    Subnet      = "${each.key}-${each.value}"
  }

}



