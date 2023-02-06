terraform {
  source = "../../modules//route-table/"
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
    public_subnets = [{id= "subnets-fake-id"},{id="subnets-fake-id"}]
  }
}

dependency "igw" {
  config_path                             = "../igw/"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"] # Configure mock outputs for the "init", "validate", "plan" commands that are returned when there are no outputs available (e.g the module hasn't been applied yet.)
  mock_outputs = {
    igw_id = "gw-fake-id"
  }
}

inputs = {
  vpc_id              = dependency.vpc.outputs.vpc_id
  public_subnets      = dependency.vpc.outputs.public_subnets
  igw_id              = dependency.igw.outputs.igw_id
}