variable "region" {
  description = "Regiao onde o recurso sera criado"
  type        = string
}

variable "name" {
  description = "Nome do IAM Role"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN do OIDC Provider do EKS"
  type        = string
}

variable "oidc_provider_url" {
  description = "URL do OIDC Provider (sem https://)"
  type        = string
}

variable "service_account_subject" {
  description = "Subject do Service Account no Kubernetes"
  type        = string
}

variable "policy_arn" {
  description = "ARN da política a ser anexada"
  type        = string
}
