module "networking" {
  source = "./modules/networking"

  cidr_block         = var.cidr_block
  availability_zones = var.availability_zones

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_hostnames

  instance_tenancy = var.instance_tenancy

  ipv4_ipam_pool_id   = var.ipv4_ipam_pool_id
  ipv4_netmask_length = var.ipv4_netmask_length

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  public_map_public_ip_on_launch  = var.public_map_public_ip_on_launch
  private_map_public_ip_on_launch = var.private_map_public_ip_on_launch

  cluster_name = var.cluster_name

  single_nat_gateway = var.single_nat_gateway
  nat_count          = var.nat_count

}

module "security" {
  source = "./modules/security"

  vpc_id = module.networking.vpc_id
}

module "eks_cluster" {
  source = "./modules/containerisation"

  create_cluster = var.create_cluster

  cluster_name            = var.cluster_name
  cluster_version         = var.cluster_version
  eks_subnets_id          = module.networking.private_subnets[0]
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
  public_access_cidrs     = var.public_access_cidrs
  cluster_timeouts        = var.cluster_timeouts

  node_group_name = var.node_group_name

  ami_type                  = var.ami_type
  ec2_ssh_key               = var.ec2_ssh_key
  node_group_security_group = module.security.node_group_sg
  node_group_subnet         = module.networking.public_subnets[0]
  instance_type             = var.instance_type
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_size              = var.desired_size
}
