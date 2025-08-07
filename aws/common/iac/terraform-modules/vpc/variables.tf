variable "region" {
  description = "Regiao onde o recurso sera criado"
  type        = string
}
variable "vpc_name" {
  description = "Nome da VPC"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
}
variable "vpc_azs" {
  description = "Zones da VPC"
  type        = list(string)
}
variable "vpc_private_subnets_cidr" {
  description = "CIDRs da subnets Privada"
  type        = list(string)
}
variable "vpc_public_subnets_cidr" {
  description = "CIDRs da subnets Pública"
  type        = list(string)
}
variable "vpc_tags" {
  description = "Tags para VPC"
  type        = map(string)
}
variable "public_subnet_tags" {
  description = "Tags adicionais para public subnets"
  type        = map(string)
  default     = {}
}
variable "private_subnet_tags" {
  description = "Tags adicionais para private subnets"
  type        = map(string)
  default     = {}
}
variable "eks_cluster_name" {
  description = "Nome do Cluster EKS"
  type        = string
}
