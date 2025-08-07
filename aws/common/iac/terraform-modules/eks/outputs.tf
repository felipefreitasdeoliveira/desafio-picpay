output "eks_oidc_provider" {
  description = "EKS OIDC provider URL"
  value       = module.eks.oidc_provider
}

output "eks_oidc_provider_arn" {
  description = "EKS OIDC provider ARN"
  value       = module.eks.oidc_provider_arn
}