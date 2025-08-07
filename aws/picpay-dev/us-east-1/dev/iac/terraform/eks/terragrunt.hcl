terraform {
  source = "../../../../../../common/iac/terraform-modules/eks"
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  node_groups_config = read_terragrunt_config(find_in_parent_folders("eks/node_groups.hcl"))
  env                = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals

}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id          = "vpc-1234567890abcdef0"
    private_subnets = ["subnet-aaaaaaaa", "subnet-bbbbbbbb", "subnet-cccccccc"]
    public_subnets  = ["subnet-dddddddd", "subnet-eeeeeeee", "subnet-ffffffff"]
  }

}

inputs = {
  region                   = "us-east-1"
  eks_cluster_name         = local.env.eks.cluster_name
  eks_kubernetes_version   = "1.32"
  eks_tags                 = local.env.eks.cluster_tags
  vpc_id                   = dependency.vpc.outputs.vpc_id
  subnet_ids               = dependency.vpc.outputs.private_subnets
  control_plane_subnet_ids = dependency.vpc.outputs.public_subnets
  addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
    eks-pod-identity-agent = {
      before_compute = true
    }
    aws-ebs-csi-driver = {}
  }

  eks_managed_node_groups = local.node_groups_config.locals.eks_managed_node_groups
}
