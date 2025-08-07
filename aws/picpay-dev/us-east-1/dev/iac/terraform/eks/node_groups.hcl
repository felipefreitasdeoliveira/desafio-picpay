locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals

  eks_managed_node_groups = {
    default = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 2
      desired_size = 1

      labels = local.env.eks.cluster_labels
      tags   = local.env.eks.cluster_tags
    }
  }
}
