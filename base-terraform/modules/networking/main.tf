resource "aws_vpc" "kubernetes" {

  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  instance_tenancy = var.instance_tenancy == null ? "default" : var.instance_tenancy

  ipv4_ipam_pool_id         = var.ipv4_ipam_pool_id
  ipv4_netmask_length       = var.ipv4_ipam_pool_id == null ? var.ipv4_ipam_pool_id : var.ipv4_netmask_length

  tags = {
    Name = "kubernetes-vpc"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.kubernetes.id
  availability_zone       = length(regexall("^[a-z]{2}-", element(var.availability_zones, count.index))) > 0 ? element(var.availability_zones, count.index) : null
  cidr_block              = element(var.public_subnets, count.index)
  map_public_ip_on_launch = var.public_map_public_ip_on_launch

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = 1
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.kubernetes.id

  tags = {
    Name = "Internet gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.kubernetes.id

  tags = {
    Name = "Public route table"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "route_to_igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id

  timeouts {
    create = "5m"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id                  = aws_vpc.kubernetes.id
  availability_zone       = length(regexall("^[a-z]{2}-", element(var.availability_zones, count.index))) > 0 ? element(var.availability_zones, count.index) : null
  cidr_block              = element(var.private_subnets, count.index)
  map_public_ip_on_launch = var.private_map_public_ip_on_launch

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = 1
  }
}


resource "aws_eip" "elastic_ip" {
  count = var.single_nat_gateway && var.nat_count == null ? 1 : var.nat_count

  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  count = var.single_nat_gateway && var.nat_count == null ? 1 : var.nat_count

  allocation_id = element(aws_eip.elastic_ip[*].id, var.single_nat_gateway ? 0 : count.index)
  subnet_id     = element(aws_subnet.public[*].id, var.single_nat_gateway ? 0 : count.index)
}

resource "aws_route_table" "private" {
  count = var.single_nat_gateway && var.nat_count == null ? 1 : var.nat_count

  vpc_id = aws_vpc.kubernetes.id

  tags = {
    Name = "Private route table ${count.index + 1}"
  }
}


resource "aws_route_table_association" "private" {
  count = var.single_nat_gateway && var.nat_count == null ? 1 : var.nat_count

  subnet_id      = element(aws_subnet.private[*].id, var.single_nat_gateway ? 0 : count.index)
  route_table_id = element(aws_route_table.private[*].id, var.single_nat_gateway ? 0 : count.index)

}

resource "aws_route" "route_to_nat" {
  count = var.single_nat_gateway && var.nat_count == null ? 1 : var.nat_count

  route_table_id         = element(aws_route_table.private[*].id, var.single_nat_gateway ? 0 : count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat[*].id, var.single_nat_gateway ? 0 : count.index)

  timeouts {
    create = "5m"
  }
}
