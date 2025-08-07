terraform {
  source = "../../../../../../common/iac/terraform-modules/irsa"
}

include "root" {
  path = find_in_parent_folders()
}


locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals

}

dependency "eks" {
  config_path = "../eks"

  mock_outputs = {
    eks_oidc_provider     = "oidc.eks.us-east-1.amazonaws.com/id/MOCK"
    eks_oidc_provider_arn = "arn:aws:iam::123456789012:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/MOCK"
  }
}

inputs = {
  name                    = "irsa-web-app"
  oidc_provider_arn       = dependency.eks.outputs.eks_oidc_provider_arn
  oidc_provider_url       = dependency.eks.outputs.eks_oidc_provider
  service_account_subject = "system:serviceaccount:dev:irsa-sa"
  policy_arn              = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
