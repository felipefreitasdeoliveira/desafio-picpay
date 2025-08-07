variable "vpc_id" {
  description = "ID da VPC"
  type        = string
  default     = null
}
variable "region" {
  description = "Regiao onde o recurso sera criado"
  type        = string
}
variable "eks_cluster_name" {
  description = "Nome da eks"
  type        = string
}
variable "subnet_ids" {
  description = "IDs das subnets privadas"
  type        = list(string)
  default     = []
}
variable "control_plane_subnet_ids" {
  description = "IDs das subnets públicas"
  type        = list(string)
  default     = []
}
variable "eks_kubernetes_version" {
  description = "Versão do Kubernetes"
  type        = string
}

variable "endpoint_public_access" {
  description = "endpoint EKS será publico?"
  type        = bool
  default     = true
}
variable "enable_cluster_creator_admin_permissions" {
  description = "Criador do cluster deve ser adicionado no access entries"
  type        = bool
  default     = true
}
variable "eks_tags" {
  description = "Tags para eks"
  type        = map(string)
}
variable "eks_managed_node_groups" {
  description = "Map with EKS managed node group configurations"
  type        = any
  default     = {}
}
variable "addons" {
  description = "Map dos EKS addons"
  type        = map(any)
  default     = {}
}

