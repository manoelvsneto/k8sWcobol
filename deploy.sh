#!/bin/bash

# Definições
REGISTRY="seu-registry"
IMAGE_NAME="cobol-app"
TAG="latest"
FULL_IMAGE_NAME="${REGISTRY}/${IMAGE_NAME}:${TAG}"

# Construção da imagem Docker para ARM64
echo "Construindo imagem Docker para ARM64..."
docker buildx build --platform linux/arm64 -t ${FULL_IMAGE_NAME} --push .

# Implantação no Kubernetes
echo "Implantando no Kubernetes..."
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

echo "Implantação concluída!"