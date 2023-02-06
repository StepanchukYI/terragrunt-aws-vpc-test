variable "vpc_id" {
  description = "AWS VPC ID."
  type        = string
}

variable "igw_id" {
  description = "AWS Internet Gateway ID."
  type        = string
}

variable "public_subnets" {
  type        = list(object({id = string}))
  description = "List of IDs of public subnets"
}