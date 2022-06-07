output "vpc_id" {
  value = aws_vpc.vpc.id
}
 
output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}
 
output "vpc_public_subnets" {
  # returns map of public subnet id to cidr block
  value = {
    for subnet in aws_subnet.public :
    subnet.id => subnet.cidr_block
  }
}
 
output "vpc_private_subnets" {
  # returns map of private subnets id to cidr block
  value = {
    for subnet in aws_subnet.private :
    subnet.id => subnet.cidr_block
  }
}
