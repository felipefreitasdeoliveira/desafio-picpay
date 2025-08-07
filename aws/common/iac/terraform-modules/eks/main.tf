module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name                                     = var.eks_cluster_name
  kubernetes_version                       = var.eks_kubernetes_version
  addons                                   = var.addons
  endpoint_public_access                   = var.endpoint_public_access
  vpc_id                                   = var.vpc_id
  subnet_ids                               = var.subnet_ids
  control_plane_subnet_ids                 = var.control_plane_subnet_ids
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions
  eks_managed_node_groups                  = var.eks_managed_node_groups
  tags                                     = var.eks_tags
}