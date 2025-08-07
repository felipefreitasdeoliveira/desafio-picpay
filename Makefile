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


# Comportamento padrão
.PHONY: all build push helm-deploy

all: build push helm-deploy

## 🏗️  Build da imagem Podman
build:
	@echo "🏗️  Buildando imagem Podman: $(IMAGE_NAME)"
	podman build -f $(DOCKERFILE) -t $(IMAGE_NAME) $(APP_PATH)

## 🚀 Push da imagem para o ECR
push:
	@echo "🚀 Fazendo push da imagem: $(IMAGE_NAME)"
	aws ecr-public get-login-password --region us-east-1 | podman login --username AWS --password-stdin $(DOCKER_REGISTRY)
	podman push $(IMAGE_NAME)

## 🎯 Deploy via Helm
helm-deploy:
	@echo "🎯 Fazendo deploy Helm no namespace $(NAMESPACE)"
	helm upgrade --install $(APP_NAME) -f $(CHART_PATH)/values-$(ENVIRONMENT).yaml $(CHART_PATH) \
		--namespace $(NAMESPACE) \
		--create-namespace \
		--set image.repository=$(DOCKER_REGISTRY)/$(APP_NAME) \
		--set image.tag=$(IMAGE_TAG)



