# Region Configuration

region = "eu-west-2"

# ------------------------------------------------------------

# VPC Configuration

cidr_block   = "10.0.0.0/20"
private_subnets = [
  "10.0.1.0/24", 
  "10.0.2.0/24", 
  "10.0.3.0/24"
]
public_subnets = [
  "10.0.4.0/24", 
  "10.0.5.0/24", 
  "10.0.6.0/24"
]
enable_dns_hostnames = true
enable_dns_support = true
availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]

instance_tenancy = "default"


public_map_public_ip_on_launch = true
private_map_public_ip_on_launch = false

single_nat_gateway = true
#if single ngw = false, you can specify as many ngw as you need
nat_count = null


# ------------------------------------------------------------

# EKS Cluster Configuration

cluster_name = "karv-cluster"
cluster_version = "1.27"
node_group_name = "karv-node-group"
endpoint_private_access = false
endpoint_public_access = false
public_access_cidrs = [ "0.0.0.0/0" ]

ami_type = "AL2_x86_64"
ec2_ssh_key = "my-key.pem"
instance_type = [ "t3.micro" ]
max_size = 3
min_size = 3
desired_size = 3

cluster_timeouts = {
  create = "20m"
  update = "20m"
  delete = "25m"
}