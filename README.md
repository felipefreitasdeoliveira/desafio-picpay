# Infraestrutura e Deploys na AWS

Este repositório contém a infraestrutura de um ambiente na AWS, utilizando **IaC (Infrastructure as Code)**.
A estrutura atual permite a criação de ambientes **escaláveis** e **replicáveis**.

---

## 📌 Visão Geral do Projeto

O projeto é dividido em duas partes principais:

- **Módulos Reutilizáveis** (`aws/common/iac/terraform-modules`):  
  Conjunto de módulos Terraform que definem a infraestrutura comum e reutilizáveis entre diferentes ambientes e contas AWS. Isso garante padronização e evita duplicação de código.

- **Implementação do Ambiente Específico** (`aws/picpay-dev/us-east-1/dev`):  
  Contém configurações para o ambiente de desenvolvimento, utilizando **Terragrunt** para orquestrar os módulos Terraform e definir os componentes de plataforma e aplicação a serem implantados no cluster Kubernetes.

---

## 📁 Estrutura do Repositório

### `aws/common/`

- **eks**: Módulo Terraform para provisionar um cluster Amazon EKS.  
- **irsa**: Módulo para configurar o IRSA (IAM Roles for Service Accounts).  
- **vpc**: Módulo para criar a VPC, subnets e outros recursos de rede necessários.

### `aws/picpay-dev/us-east-1/dev`

- **deployments**
  - `app`: Código-fonte da aplicação de exemplo (`index.html`) e `Dockerfile`.
  - `helm-charts/web-app`: Helm Chart com definições de Deployment, Service, Ingress etc.
  
- **iac/terraform**:  
  Lógica de orquestração do Terragrunt, utilizando os módulos de `aws/common`.

- **platform/k8s**:  
  Configurações de addons para o cluster Kubernetes.

- **helm-values**:  
  Repositório com `values.yaml` dos Helm Charts de plataforma, como:
  - `kube-monitoring` (Prometheus, Grafana, etc)
  - `nginx-ingress` para gerenciamento de tráfego

- **manifests**:  
  Arquivos YAML para recursos iniciais do Kubernetes (ex: `namespaces.yaml`, `irsa-sa.yaml`).

- **Makefile**:  
  Contém comandos de automação para tarefas como `terragrunt apply` e `helm install`.

---

## 🛠 Tecnologias-Chave

- **AWS EKS** – Kubernetes totalmente gerenciado pela AWS  
- **Terraform** – Provisionamento da infraestrutura como código  
- **Terragrunt** – Wrapper para manter configurações DRY e gerenciar ambientes  
- **Helm** – Gerenciador de pacotes para Kubernetes  
- **Docker** – Empacotamento da aplicação em contêiner  
- **Nginx Ingress** – Roteamento HTTP/HTTPS dentro do cluster  
- **Prometheus / Grafana** – Monitoramento e visualização

---

## ▶️ Como Usar

### ✅ Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas:

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Terragrunt](https://terragrunt.gruntwork.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/)

---

### 🚀 Provisionamento da Infraestrutura

Na pasta raiz pode rodar os comandos `make` para aplicar os componentes.

```bash
# Exemplo: 

make terragrunt_init
make terragrunt_apply
make terragrunt_destroy
```

# 🌐 Recursos Criados no Ambiente

Abaixo estão os principais recursos disponíveis após a implantação da infraestrutura e dos serviços na AWS:

## 🔗 Endpoints de Acesso

- [Web App](http://web-app.compwave.com.br) – Aplicação de exemplo implantada no cluster EKS  
- [Grafana](http://grafana.compwave.com.br) – Dashboard de visualização de métricas e gráficos  
- [Prometheus](http://prometheus.compwave.com.br) – Coleta e armazenamento de métricas do cluster  
- [Alertmanager](http://alertmanager.compwave.com.br) – Gerenciamento e roteamento de alertas
