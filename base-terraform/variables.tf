# AWS Region

variable "region" {
  description = "AWS region"
  type        = string
}

# ------------------------------------------------------------


# Networking 


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
  default     = null
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


variable "public_subnets" {
  description = "A list of CIDR blocks for public subnets"
  type        = list(string)
}

variable "public_map_public_ip_on_launch" {
  description = "Whether to map public IP addresses on launch in public subnets"
  type        = bool
  default     = true
}

variable "private_subnets" {
  description = "A list of CIDR blocks for private subnets"
  type        = list(string)
}

variable "private_map_public_ip_on_launch" {
  description = "Whether to map public IP addresses on launch in private subnets"
  type        = bool
  default     = false
}

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


variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

# ------------------------------------------------------------

# EKS Cluster Configuration

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "The name of the EKS node group"
  type        = string
}

variable "min_size" {
  description = "Minimum number of nodes in the node group"
  type        = number
}

variable "max_size" {
  description = "Maximum number of nodes in the node group"
  type        = number
}

variable "desired_size" {
  description = "Desired number of nodes in the node group"
  type        = number
}

variable "ami_type" {
  description = "AMI type for the EKS node group"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EKS node group"
  type        = list(string)
}

variable "cluster_timeouts" {
  description = "Timeouts for creating, updating, and deleting the EKS cluster"
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = {}
}

variable "endpoint_private_access" {
  description = "Whether the EKS cluster should have private access to the Kubernetes API server"
  type        = bool
  default     = false
}

variable "endpoint_public_access" {
  description = "Whether the EKS cluster should have public access to the Kubernetes API server"
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "List of CIDR blocks allowed to access the EKS cluster's public endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}


variable "create_cluster" {
  description = "Whether to create the EKS cluster and node group"
  type        = bool
  default     = true
}

variable "ec2_ssh_key" {
  type = string
}