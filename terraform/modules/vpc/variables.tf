variable "vpc_cidr_block" {
    type = string
    description = "VPC cidr block"
    default = "10.0.0.0/16" 
}


variable "public_subnet_numbers" {
  type = map(number)
  description = "map of region AZ to number that should be used for public subnets"
 
  default = {
    "us-east-1a" = 1
    "us-east-1b" = 2
    "us-east-1c" = 3
    "us-east-1d" = 4
    "us-east-1e" = 5
    "us-east-1f" = 6
  }
}
 

variable "private_subnet_numbers" {
  type = map(number)
  description = "map of region AZ to number that should be used for private subnets"
  default = {
    "us-east-1a" = 7
    "us-east-1b" = 8
    "us-east-1c" = 9
    "us-east-1d" = 10
    "us-east-1e" = 11
    "us-east-1f" = 12
  }
}
 
 
variable "infra_env" {
  type        = string
  description = "infrastructure environment"
  default = "dev"
}

# # example for tags
# variable "tags" {
#   type = map(string)
#   default = {}
#   description = "tags for the ec2 instance"
# }

  # tags = merge( 
  #   {
  #     Name        = "cloudcasts-${var.infra_env}"
  #     Role        = var.infra_role
  #     Project     = "cloudcasts.io"
  #     Environment = var.infra_env
  #     ManagedBy   = "terraform"
  #   },
  #   var.tags
  # )
