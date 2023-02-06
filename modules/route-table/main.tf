terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.7"
    }
  }
}

resource "aws_route_table" "igw-route" {
 vpc_id = var.vpc_id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = var.igw_id
 }
 
 tags = {
   Name = "2nd Route Table"
 }
}


resource "aws_route_table_association" "public_subnet_asso" {
 count = length(var.public_subnets)
 subnet_id      = element(var.public_subnets[*].id, count.index)
 route_table_id = aws_route_table.igw-route.id
}