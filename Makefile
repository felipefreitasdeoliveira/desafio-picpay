# Variáveis de configuração
APP_PATH := aws/picpay-dev/us-east-1/dev/deployments/app
DOCKERFILE := $(APP_PATH)/Dockerfile
HTML_DIR := $(APP_PATH)/html
ENVIRONMENT := dev
APP_NAME := web-app
NAMESPACE := default
CHART_PATH := aws/picpay-dev/us-east-1/dev/deployments/helm-charts/$(APP_NAME)
DOCKER_REGISTRY := public.ecr.aws/p5o5s5p6/desafio-picpay
IMAGE_TAG := $(shell git rev-parse --short HEAD)
IMAGE_NAME := $(DOCKER_REGISTRY)/$(APP_NAME):$(IMAGE_TAG)
TERRAGRUNT_DIR ?= aws/picpay-dev/us-east-1/dev/iac/terraform
CHART_PATH_PLATFORM := aws/picpay-dev/us-east-1/dev/platform/k8s/helm-values


# Comportamento padrão
.PHONY: all build push helm-deploy 

all: build push helm-deploy terragrunt-plan

## Build da imagem Podman
build:
	@echo "--- Build imagem Podman: $(IMAGE_NAME) ---"
	podman build -f $(DOCKERFILE) -t $(IMAGE_NAME) $(APP_PATH)

push:
	@echo "--- Fazendo push da imagem: $(IMAGE_NAME) ---"
	aws ecr-public get-login-password --region us-east-1 | podman login --username AWS --password-stdin $(DOCKER_REGISTRY)
	podman push $(IMAGE_NAME)

## Deploy webp-app via Helm
helm-install-web-app:
	@echo "--- Fazendo deploy do helmcharts web-app ---"
	helm upgrade --install $(APP_NAME) -f $(CHART_PATH)/values-$(ENVIRONMENT).yaml $(CHART_PATH) \
		--namespace $(NAMESPACE) \
		--create-namespace \
		--set image.repository=$(DOCKER_REGISTRY)/$(APP_NAME) \
		--set image.tag=$(IMAGE_TAG)

## Terragrunt
terragrunt_init:
	@echo "--- Inicializando Terragrunt em: $(TERRAGRUNT_DIR) ---"
	terragrunt run-all init --terragrunt-working-dir $(TERRAGRUNT_DIR)

terragrunt_plan:
	@echo "--- Gerando plan do Terragrunt em: $(TERRAGRUNT_DIR) ---"
	terragrunt run-all plan --terragrunt-working-dir $(TERRAGRUNT_DIR)

terragrunt_apply:
	@echo "--- Aplicando Terragrunt em: $(TERRAGRUNT_DIR) ---"
	terragrunt run-all apply --terragrunt-working-dir $(TERRAGRUNT_DIR)

terragrunt_destroy:
	@echo "--- Destruindo recursos Terragrunt em: $(TERRAGRUNT_DIR) ---"
	terragrunt run-all destroy --terragrunt-working-dir $(TERRAGRUNT_DIR)

## Deploy manifests
k_apply_ns:
	@echo "--- Criando namespaces ---"
	kubectl apply -f aws/picpay-dev/us-east-1/dev/platform/k8s/manifests/namespaces.yaml
k_delete_ns:
	@echo "--- Deletando namespaces ---"
	kubectl delete -f aws/picpay-dev/us-east-1/dev/platform/k8s/manifests/namespaces.yaml

## Deploy helmcharts nginx-ingress
helm-install-nginx-ingress:
	@echo "--- Fazendo deploy do helmcharts nginx-ingress ---"
	helm upgrade --install nginx-ingress -f $(CHART_PATH_PLATFORM)/nginx-ingress/custom-values/values-dev.yaml $(CHART_PATH_PLATFORM)/nginx-ingress/ \
		--namespace ingress 

helm-uninstall-nginx-ingress:
	@echo "--- Removendo deploy do helmcharts nginx-ingress ---"
	helm uninstall nginx-ingress --namespace ingress 
