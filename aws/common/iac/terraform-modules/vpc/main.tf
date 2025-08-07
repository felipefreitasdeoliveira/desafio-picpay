module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets_cidr
  public_subnets  = var.vpc_public_subnets_cidr

  create_database_subnet_group  = false
  manage_default_network_acl    = true
  manage_default_route_table    = true
  manage_default_security_group = true
  enable_dns_hostnames          = true
  enable_dns_support            = true
  enable_nat_gateway            = true
  single_nat_gateway            = true

  enable_flow_log                      = false
  create_flow_log_cloudwatch_log_group = false
  create_flow_log_cloudwatch_iam_role  = false
  flow_log_max_aggregation_interval    = 60

  tags                = var.vpc_tags
  public_subnet_tags  = var.public_subnet_tags
  private_subnet_tags = var.private_subnet_tags
}
