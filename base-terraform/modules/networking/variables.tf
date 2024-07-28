# Networking 

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Enable or disable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable or disable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  description = "The instance tenancy option for the VPC"
  type        = string
  default     = "default"
}

variable "ipv4_ipam_pool_id" {
  description = "The ID of the IPv4 IPAM pool for the VPC"
  type        = string
  default     = null
}

variable "ipv4_netmask_length" {
  description = "The netmask length for the IPv4 IPAM pool"
  type        = number
  default     = 24
}

variable "single_nat_gateway" {
  description = "Create a single NAT gateway for the VPC"
  type        = bool
  default     = true
}

variable "nat_count" {
  description = "The number of NAT gateways to create"
  type        = number
  default     = null
}

# Subnet Variables

variable "public_map_public_ip_on_launch" {
  description = "Whether to map public IP addresses on launch in public subnets"
  type        = bool
  default     = true
}

variable "private_map_public_ip_on_launch" {
  description = "Whether to map public IP addresses on launch in private subnets"
  type        = bool
  default     = false
}

# General Variables
variable "availability_zones" {
  description = "A list of availability zones to use for the VPC and subnets"
  type        = list(string)
}



# Names of the resources


variable "cluster_name" {
  description = "The name of the EKS cluster - used for identifying network aspects with tags"
  type        = string
}

# ------------------------------------------------------------

# CIDR blocks and subnet IDs

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}
