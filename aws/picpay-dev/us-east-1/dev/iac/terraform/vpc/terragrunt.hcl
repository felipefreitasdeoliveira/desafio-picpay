terraform {
  source = "../../../../../../common/iac/terraform-modules/vpc"
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals
}

inputs = {
  vpc_name                 = local.env.vpc.vpc_name
  vpc_cidr                 = "10.15.0.0/20"
  region                   = "us-east-1"
  vpc_private_subnets_cidr = ["10.15.0.0/24", "10.15.1.0/24"]
  vpc_public_subnets_cidr  = ["10.15.14.0/24", "10.15.15.0/24"]
  vpc_tags = {
    "environment" : "dev"
    "project" : "desafiopicpay"
  }
  public_subnet_tags = {
    "kubernetes.io/role/elb"                              = "1"
    "kubernetes.io/cluster/${local.env.eks.cluster_name}" = "shared"
    "tier"                                                = "public"

  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"                     = "1"
    "kubernetes.io/cluster/${local.env.eks.cluster_name}" = "shared"
    "tier"                                                = "private"
  }
  eks_cluster_name = local.env.eks.cluster_name
}
