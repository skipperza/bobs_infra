# Create a personal lab with all sorts of devopsy things
provider "aws" {
  # Credentials expected from ENV or ~/.aws/credentials
  version = "~> 2.0"
  region  = var.primary_aws_region
}

# First we setup all networking related concerns, like a VPC and default security groups.
# External modules can be restrictive at times, but ther are quite convenient so...
module "main_vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"

  name = join("-", [var.name_prefix, "main-vpc"])
  cidr = var.main_vpc_cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.main_vpc_private_subnets
  public_subnets  = var.main_vpc_public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = false

  create_database_subnet_group = false

  tags = {
    Terraform = "true"
    Environment = var.environment
    Managed = "true"
  }
}
