# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  generate = {
    path      = "test.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "demo-terragrunt-states-test"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = "demo-terragrunt-states-test"
  }
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region  = var.aws_region
  profile = var.profile
  default_tags {
    tags = var.default_tags
  }
}
variable "aws_region" {
  description = "AWS Region."
}
variable "profile" {
  description = "AWS Profile."
}
variable "default_tags" {
  type        = map(string)
  description = "Default tags for AWS that will be attached to each resource."
}
EOF
}

locals {
  aws_region        = "eu-north-1"
  deployment_prefix = "demo-terragrunt"
  profile           = "terragrunt"
}

inputs = {
  aws_region        = local.aws_region
  deployment_prefix = local.deployment_prefix
  profile           = local.profile
  default_tags = {
    "TerminationDate"  = "Permanent",
    "Environment"      = "Development",
    "Team"             = "DevOps",
    "DeployedBy"       = "Terragrunt",
    "OwnerEmail"       = "bodunjo855@gmail.com"
    "DeploymentPrefix" = local.deployment_prefix
  }
}
