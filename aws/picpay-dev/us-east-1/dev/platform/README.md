
# Deploy de Aplicação Web com Podman, Docker Hub e Helm

Este guia mostra como buildar, testar localmente, enviar a imagem para o Docker Hub e realizar o deploy da aplicação em um cluster Kubernetes utilizando Helm.

---
## Estrutura de Diretórios

Estrutura de diretórios do projeto.

```hcl
.
├── deployments
│   ├── app
│   │   ├── Dockerfile
│   │   └── html
│   │       └── index.html
│   ├── helm-charts
│   │   └── web-app
│   │       ├── Chart.yaml
│   │       ├── templates
│   │       ├── values-dev.yaml
│   │       └── values.yaml
│   └── README.md
├── iac
│   └── terraform
│       ├── eks
│       │   ├── node_groups.hcl
│       │   └── terragrunt.hcl
│       ├── env.hcl
│       ├── irsa
│       │   └── terragrunt.hcl
│       ├── terragrunt.hcl
│       └── vpc
│           └── terragrunt.hcl
└── platform
    ├── k8s
    │   ├── helm-values
    │   │   ├── monitoring
    │   │   │   ├── Chart.yaml
    │   │   │   ├── charts
    │   │   │   ├── custom-values
    │   │   │   │   ├── values-infra.yaml
    │   │   │   │   └── values.yaml
    │   │   │   ├── templates
    │   │   │   └── values.yaml
    │   │   └── nginx-ingress
    │   │       ├── Chart.yaml
    │   │       ├── charts
    │   │       ├── custom-values
    │   │       │   └── values-dev.yaml
    │   │       ├── README.md
    │   │       └── values.yaml
    │   └── manifests
    └── README.md
```

---
## Pré-requisitos

1. Podman Desktop instalado no seu Mac → [podman.io](https://podman.io/)
2. Estrutura de pastas como esta:

## Plataforma Kubernetes e Helm

### `platform/k8s`

Este diretório contém a estrutura de gerenciamento para a nossa plataforma Kubernetes, com foco na orquestração de ferramentas e serviços através do **Helm**. A organização é dividida em charts (`helm-values`) e manifestos estáticos (`manifests`).

### `helm-values`

Este subdiretório armazena todos os **Helm Charts personalizados** e seus respectivos arquivos de (`values.yaml`).

- **`monitoring`**:  
  Configura o monitoramento do cluster, que inclui ferramentas como **Prometheus**, **Grafana**, entre outras.

- **`nginx-ingress`**:  
  Gerencia a implantação do **NGINX Ingress Controller**, que é responsável por rotear o tráfego externo para os serviços dentro do cluster.

### 📜 `manifests`

Esta pasta contém os **manifestos estáticos do Kubernetes** que são aplicados diretamente com o `kubectl apply -f {file_name.yaml}`. 

Eles definem recursos basicos do cluster que não são gerenciados por um Helm Chart, garantindo que eles existam antes da implantação de outras ferramentas.

## Como Usar

Para gerenciar as ferramentas de plataforma, você pode usar um **Makefile** na raiz do projeto ou **comando de shell** que referenciam os arquivos de `values` e `manifestos` definidos.
