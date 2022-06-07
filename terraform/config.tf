terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.17.1"
    }
  }

  backend "s3" {
    bucket = "terraform-SF"
    key    = "aline/DISCRIPTION.tfstate"
    region = "us-east-1"
  }

}

provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
}

# tag = {
#     Name = "name of what this is"
#     Project = "track all things in project"
#     Environment = "environment in that project"
#     ManagedBy = "terraform"
# }

# associate to not loose eip

# dynamo db for locking state file
