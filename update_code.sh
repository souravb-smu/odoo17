#!/bin/bash
set -e

DEPLOY_DIR="/home/azureuser/deploy-temp"

echo "[1] Navigating to deploy directory"
cd $DEPLOY_DIR

echo "[2] Stopping existing containers"
docker compose down

echo "[3] Pulling latest images"
docker compose pull

echo "[4] Building and starting containers"
docker compose up --build -d

echo "[5] Deployment complete"
docker ps