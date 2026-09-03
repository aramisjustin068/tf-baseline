variable "name" {
  description = "Prefix used for every resource name and the Name tag."
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC. Must be large enough for /20 subnets."
  type        = string
  default     = "10.0.0.0/16"
}

variable "az_count" {
  description = "Number of availability zones to span."
  type        = number
  default     = 2

  validation {
    condition     = var.az_count >= 1 && var.az_count <= 4
    error_message = "az_count must be between 1 and 4."
  }
}

variable "enable_nat_gateway" {
  description = "Create a single NAT gateway so private subnets get egress."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Extra tags merged into every resource."
  type        = map(string)
  default     = {}
}
