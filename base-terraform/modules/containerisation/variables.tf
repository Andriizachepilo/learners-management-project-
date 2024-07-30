variable "create_cluster" {
  description = "Whether to create the EKS cluster and node group"
  type        = bool
  default     = true
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}


variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "eks_subnets_id" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
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

variable "cluster_timeouts" {
  description = "Timeouts for creating, updating, and deleting the EKS cluster"
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = {}
}

variable "node_group_name" {
  description = "The name of the node group"
  type        = string
}

variable "node_group_subnet" {
  description = "List of subnet IDs for the EKS node group"
  type        = list(string)
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

variable "node_group_security_group" {
  type = list(string)
}

variable "ec2_ssh_key" {
  type = string
}

