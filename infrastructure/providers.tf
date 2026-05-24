# ==============================================================================
# COMPONENT: Terraform Core Provider Definitions (Local Emulation Mode)
# PURPOSE:   Binds required API engines and redirects traffic to LocalStack.
#
# DESIGN NOTES:
# - All requests are forced to route inward to local container port 4566.
# - Cleaned for modern v5 provider endpoint schema structures.
# ==============================================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Core AWS provider configured with mock credentials to bypass live validation
provider "aws" {
  region                      = var.aws_region
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # Redirect all active service resource calls to the internal container
  endpoints {
    ec2 = "http://localhost:4566"
  }
}
