module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "192.168.0.0/16"
  vpc_name = "project-vpc"
}

module "subnet" {
  source   = "./modules/subnet"
  vpc_id   = module.vpc.vpc_id
  vpc_cidr = "192.168.0.0/16"
  az1      = "ap-south-1a"
  az2      = "ap-south-1b"
}

module "internet_gateway" {
  source  = "./modules/internet_gateway"
  vpc_id  = module.vpc.vpc_id
  igw_name = "project-igw"
}

module "nat_gateway" {
  source           = "./modules/nat_gateway"
  public_subnet1_id = module.subnet.public_subnet1_id
  nat_gateway_name = "project-natgw"
}

module "route_table" {
  source            = "./modules/route_table"
  vpc_id            = module.vpc.vpc_id
  igw_id            = module.internet_gateway.project_igw_id
  nat_gateway_id    = module.nat_gateway.project_natgw_id
  public_subnet1_id = module.subnet.public_subnet1_id
  public_subnet2_id = module.subnet.public_subnet2_id
  private_subnet1_id = module.subnet.private_subnet1_id
  private_subnet2_id = module.subnet.private_subnet2_id
  peering_connection_id = module.peering_connection.project_peering_id
}

module "peering_connection" {
  source          = "./modules/peering_connection"
  requester_vpc_id = "vpc-0996ede71c3cf9ec2"
  accepter_vpc_id = module.vpc.vpc_id
  peering_name    = "project-peering"
}

module "nacl" {
  source           = "./modules/nacl"
  vpc_id           = module.vpc.vpc_id
  public_subnet1_id = module.subnet.public_subnet1_id
  public_subnet2_id = module.subnet.public_subnet2_id
  private_subnet1_id = module.subnet.private_subnet1_id
  private_subnet2_id = module.subnet.private_subnet2_id
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source            = "./modules/ec2"
  ami_id            = "ami-06b6e5225d1db5f46" # Ubuntu 22.04 LTS
  instance_type     = "t2.medium"
  public_subnet1_id = module.subnet.public_subnet1_id
  private_subnet1_id = module.subnet.private_subnet1_id
  private_subnet2_id = module.subnet.private_subnet2_id
  jumphost_sg_id     = module.security_groups.jumphost_sg_id
  elastic_sg_id     = module.security_groups.elastic_sg_id
  k_sg_id           = module.security_groups.k_sg_id
}

module "alb" {
  source           = "./modules/alb"
  alb_name         = "project-lb"
  lb_sg_id         = module.security_groups.lb_sg_id
  public_subnet1_id = module.subnet.public_subnet1_id
  public_subnet2_id = module.subnet.public_subnet2_id
  vpc_id           = module.vpc.vpc_id
  elasticsearch1_id = module.ec2.elasticsearch1_id
  elasticsearch2_id = module.ec2.elasticsearch2_id
  elasticsearch3_id = module.ec2.elasticsearch3_id
  elasticsearch4_id = module.ec2.elasticsearch4_id
  kibana1_id       = module.ec2.kibana1_id
  kibana2_id       = module.ec2.kibana2_id
}
