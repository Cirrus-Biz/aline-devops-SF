
# internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
 
  tags = {
    Name        = "aline-${var.infra_env}-internet_gateway"
    Project     = "aline-SF"
    Environment = var.infra_env
    VPC         = aws_vpc.vpc.id
    ManagedBy   = "terraform"
  }
}


# nat gateway eip since using EC2 NAT Image

resource "aws_eip" "nat_eip" {
  vpc = true
  lifecycle {
    prevent_destroy = true
  }
 
  tags = {
    Name        = "aline-${var.infra_env}-nat_eip"
    Project     = "aline-SF"
    Role        = "private"
    Environment = var.infra_env
    VPC         = aws_vpc.vpc.id
    ManagedBy   = "terraform"
  }
}


# currently only creating one NAT gateway, potential single point of failure
# NAT EC2 image has a base cost per hour to run, roughly $32/mo per EC2
# You'll often see one NGW per AZ created, and sometimes one per subnet.
# Note: Cross-AZ bandwidth is an extra charge, so having a NAT per AZ could be cheaper than a single NGW depending on your usage

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
 
  # Whichever the first public subnet happens to be
  # (because NGW needs to be on a public subnet with an IGW)
  # keys(): https://www.terraform.io/docs/configuration/functions/keys.html
  # element(): https://www.terraform.io/docs/configuration/functions/element.html
  subnet_id = aws_subnet.public[element(keys(aws_subnet.public), 0)].id  # gets first public subnet id
 
  tags = {
    Name        = "aline-${var.infra_env}-nat_gateway"
    Project     = "aline-SF"
    Role        = "private"
    VPC         = aws_vpc.vpc.id
    Environment = var.infra_env
    ManagedBy   = "terraform"
  }
}


###
# Route Tables, Routes and Associations
##
 
# Public Route Table (Subnets with IGW)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
 
  tags = {
    Name        = "aline-${var.infra_env}-public-route_table"
    Environment = var.infra_env
    Project     = "aline-SF"
    Role        = "public"
    VPC         = aws_vpc.vpc.id
    ManagedBy   = "terraform"
  }
}
 
# Private Route Tables (Subnets with NGW)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
 
  tags = {
    Name        = "aline-${var.infra_env}-private_route_table"
    Environment = var.infra_env
    Project     = "aline-SF"
    Role        = "private"
    VPC         = aws_vpc.vpc.id
    ManagedBy   = "terraform"
  }
}
 
 
# Public Route
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}
 
# Private Route
resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}
 
# Public Route to Public Route Table for Public Subnets
resource "aws_route_table_association" "public" {
  for_each  = aws_subnet.public
  subnet_id = aws_subnet.public[each.key].id
 
  route_table_id = aws_route_table.public.id
}
 
# Private Route to Private Route Table for Private Subnets
resource "aws_route_table_association" "private" {
  for_each  = aws_subnet.private
  subnet_id = aws_subnet.private[each.key].id
 
  route_table_id = aws_route_table.private.id
}
