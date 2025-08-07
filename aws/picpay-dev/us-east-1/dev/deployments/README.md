
# 🚀 Deploy de Aplicação Web com Podman, Docker Hub e Helm

Este guia mostra como buildar, testar localmente, enviar a imagem para o Docker Hub e realizar o deploy da aplicação em um cluster Kubernetes utilizando Helm.

---

## ✅ Pré-requisitos

1. Podman Desktop instalado no seu Mac → [https://podman.io/](https://podman.io/)
2. Estrutura de pastas como esta:

```
deployments
├── app
│   ├── Dockerfile
│   └── html
│       └── index.html
├── helm-charts
│   └── web-app
│       ├── Chart.yaml
│       ├── templates
│       │   ├── _helpers.tpl
│       │   ├── deployment.yaml
│       │   ├── hpa.yaml
│       │   ├── ingress.yaml
│       │   ├── NOTES.txt
│       │   ├── service.yaml
│       │   ├── serviceaccount.yaml
│       │   └── tests
│       │       └── test-connection.yaml
│       └── values.yaml
└── README.md
```

---

## 🛠️ 1. Acesse a pasta onde está o Dockerfile

```bash
cd deployments/app
```

---

## 🛠️ 2. Build da imagem podman

```bash
podman build -t web-app:latest .
```

> 📌 Isso criará uma imagem chamada `web-app` com a tag `latest`.

---

## 🧪 3. (Opcional) Rodar localmente para testar

```bash
podman run -d -p 8080:80 web-app:latest
```

Agora abra no navegador:

```
http://localhost:8080
```

---

## 🧼 4. Verificar se a imagem foi criada

```bash
podman images
```

## ☁️ 5. Enviar a imagem para o Docker Hub

```bash
podman login docker.io
podman tag <IMAGE_ID_OR_NAME> docker.io/<your_dockerhub_username>/<your_image_name>:<tag>
podman tag localhost/web-app:latest docker.io/oliveife/web-app:v0
podman push docker.io/<your_dockerhub_username>/<your_image_name>:<tag>

```


## 🌐 6. Deploy Kubernetes e acesso do serviço localmente via port-forward

```bash
helm upgrade --install -n default web-app -f helm-charts/web-app/values.yaml  helm-charts/web-app/

kubectl port-forward svc/web-app 8080:80
```

## 🌐 6.1. Teste a aplicação com várias requisições

Em outro terminal, teste o serviço com várias requisições:

```bash
for i in $(seq 1 50); do curl http://localhost:8080/; done

```
