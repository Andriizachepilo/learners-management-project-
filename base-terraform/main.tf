module "networking" {
  source          = "./modules/networking"

  cidr_block = var.cidr_block
  availability_zones = var.availability_zones
  
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_hostnames

  instance_tenancy = var.instance_tenancy 

  ipv4_ipam_pool_id = var.ipv4_ipam_pool_id
  ipv4_netmask_length = var.ipv4_netmask_length

  private_subnets = var.private_subnets
  public_subnets = var.public_subnets

  public_map_public_ip_on_launch = var.public_map_public_ip_on_launch
  private_map_public_ip_on_launch = var.private_map_public_ip_on_launch

  cluster_name = var.cluster_name

  single_nat_gateway = var.single_nat_gateway
  nat_count = var.nat_count

}

module "eks_cluster" {
  source              = "./modules/containerisation"
  cluster_version     = var.cluster_version
  vpc_id              = module.networking.vpc_id
  private_subnets     = module.networking.private_subnets
  cluster_name        = var.cluster_name
  eks_node_group_name = var.eks_node_group_name
}
