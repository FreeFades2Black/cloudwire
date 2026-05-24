# ==============================================================================
# COMPONENT: Global Workspace Variables
# PURPOSE:   Declares input parameters to prevent hardcoded structural elements.
# ==============================================================================

# Target deployment landing zone node for AWS core infrastructure
variable "aws_region" {
  type        = string
  description = "The target AWS Region for all core infrastructure resources"
  default     = "us-east-1"
}

# Root identification tag prefix for all instantiated resources
variable "project_name" {
  type        = string
  description = "Primary resource naming prefix deployment tag"
  default     = "cloudwire"
}
