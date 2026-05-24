# ==============================================================================
# COMPONENT: Main Cloud Infrastructure Layout
# PURPOSE:   Instantiates primary cloud resources and baseline network layers.
#
# DESIGN NOTES:
# - Uses verified modular blocks to maintain high security defaults.
# - Coordinates regional zones across the network wheel.
# ==============================================================================

# Fetch active availability zones within the target region node
data "aws_availability_zones" "available" {
  state = "available"
}

# Core Network Architecture Layer (Virtual Private Cloud)
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.project_name}-core-vpc"
  cidr = "10.0.0.0/16"

  # Map subnets dynamically across the first two available regional zones
  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # Single NAT Gateway strategy to minimize costs while maintaining private routing
  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Environment = "dev"
    Project     = var.project_name
  }
}
