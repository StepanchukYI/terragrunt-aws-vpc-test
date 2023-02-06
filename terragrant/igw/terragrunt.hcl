terraform {
  source = "../../modules//igw/"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path                             = "../vpc/"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"] # Configure mock outputs for the "init", "validate", "plan" commands that are returned when there are no outputs available (e.g the module hasn't been applied yet.)
  mock_outputs = {
    vpc_id = "vpc-fake-id"
    vpc_cidr_block = "10.0.0.0"
  }
}

inputs = {
  vpc_id              = dependency.vpc.outputs.vpc_id
}