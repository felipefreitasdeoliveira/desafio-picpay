# 📦 Módulos Terraform Compartilhados

Este diretório contém os **módulos Terraform reutilizáveis** para criar a infraestrutura na **AWS**. Seguindo o modelo de **Don't Repeat Yourself (DRY)**: cada módulo encapsula a lógica para um recurso específico, permitindo que as configurações de ambiente (`dev`, `stg`, `prd`) os utilizem de forma padronizada.

A organização é **hierárquica**, facilitando a **manutenção** e a **escalabilidade** da infraestrutura.

---
## Estrutura de Diretórios

A seguir, apresentamos a estrutura de diretórios do projeto. Esta organização foi projetada para garantir **modularidade** e **reutilização de código**, com módulos Terraform centralizados e configurações de ambiente separadas, o que facilita a escalabilidade e a manutenção.

```hcl
aws/common
└── iac
    └── terraform-modules
        ├── eks
        │   ├── main.tf
        │   ├── outputs.tf
        │   ├── provider.tf
        │   ├── terraform.tfvars
        │   └── variables.tf
        ├── irsa
        │   ├── main.tf
        │   ├── provider.tf
        │   ├── terraform.tfvars
        │   └── variables.tf
        └── vpc
            ├── main.tf
            ├── outputs.tf
            ├── provider.tf
            ├── terraform.tfvars
            └── variables.tf
```

## Módulos

### `eks`

Responsável por provisionar um **cluster Amazon EKS (Elastic Kubernetes Service)** completo. Este módulo abstrai a complexidade da criação do cluster.

* `main.tf`: Define o cluster EKS e seus componentes.
* `variables.tf`: Variáveis de entrada (ex.: nome do cluster, versão do Kubernetes, tipo de instância dos nós).
* `outputs.tf`: Informações exportadas para outros módulos.

---

### `irsa`

O módulo **IRSA (IAM Roles for Service Accounts)** é usado para segurança. Ele cria a policy e roles **IAM** que permite que as **serviceaccounts do Kubernetes** assumam uma role na AWS. Assim, **pods** podem acessar serviços como **S3** ou **DynamoDB** com segurança, sem credenciais estáticas montadas em volumes.

* `main.tf`: Recursos IAM (policy, role, OIDC provider).
* `variables.tf`: Variáveis de entrada necessárias para configuração.

---

### `vpc`

Este é o módulo de **rede base** da infraestrutura. Ele provisiona uma **Virtual Private Cloud (VPC)** na AWS com:

* Sub-nets públicas e privadas
* Internet e NAT Gateways
* Route tables
* Security Groups

* `main.tf`: Configuração da VPC e infraestrutura de rede.
* `variables.tf`: Variáveis de entrada (ex.: CIDR, nomes das sub-nets, tags).
* `outputs.tf`: Exporta dados importantes (ex.: IDs das sub-nets, ID da VPC).

---

## Como Usar

Para utilizar os módulos, navegue até o diretório do seu ambiente (`dev`, `stg`, `prd`) e crie um arquivo `terragrunt.hcl`. Dentro dele, você pode **referenciar o módulo desejado** e passar os **valores das variáveis de entrada**.

### Exemplo de uso do módulo VPC:

```hcl
terragrunt = {
    terraform {
        source = "../../../../../../common/iac/terraform-modules/vpc"
    }
}

inputs = {
  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
}
```
