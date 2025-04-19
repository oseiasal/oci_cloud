#!/bin/bash

source .env

export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION  

BUCKET_NAME="meu-backup-n8n"
BACKUP_DIR="/tmp/docker_backup_recover"
ARCHIVE_NAME=$(aws s3 ls s3://$BUCKET_NAME/ --recursive | sort | tail -n 1 | awk '{print $4}')
BACKUP_FILE_NAME=$(basename $ARCHIVE_NAME)

# Array de volumes
VOLUMES=(
  traefik_letsencrypt
  n8n_data
  nginx_data
  letsencrypt_data
  postgres_data
  grafana_data
)

echo "⛔ Parando os containers..."
docker compose down

# Criação do diretório de backup
mkdir -p "$BACKUP_DIR"

echo "☁️ Baixando o backup mais recente do S3..."
aws s3 cp "s3://$BUCKET_NAME/$ARCHIVE_NAME" "/tmp/$BACKUP_FILE_NAME"

echo "📦 Extraindo o backup..."
# Extraindo o arquivo de backup para o diretório de backup correto
tar -xzf "/tmp/$BACKUP_FILE_NAME" -C "$BACKUP_DIR"

echo "📦 Restaurando volumes..."
# Restaurando os volumes
for VOLUME in "${VOLUMES[@]}"; do
  echo "Restaurando volume: $VOLUME"
  docker run --rm -v $VOLUME:/volume -v $BACKUP_DIR:/backup alpine \
    sh -c "tar xzf /backup/$BACKUP_FILE_NAME -C /volume"
done

echo "🚀 Subindo os containers novamente..."
docker compose up -d

echo "✅ Recuperação feita e containers restaurados!"
