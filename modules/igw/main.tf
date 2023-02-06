terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.7"
    }
  }
}

resource "aws_internet_gateway" "gw" {
 vpc_id = var.vpc_id
 
 tags = {
   Name = "Project VPC IG"
 }
}