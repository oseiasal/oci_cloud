#!/bin/bash
source .env

export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION  

BUCKET_NAME="meu-backup-n8n"
BACKUP_DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="/tmp/docker_backup_$BACKUP_DATE"
ARCHIVE_NAME="backup_$BACKUP_DATE.tar.gz"

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

mkdir -p "$BACKUP_DIR"

echo "📦 Exportando volumes..."
for VOLUME in "${VOLUMES[@]}"; do
  docker run --rm -v ${VOLUME}:/volume -v $BACKUP_DIR:/backup alpine \
    sh -c "cd /volume && tar czf /backup/${VOLUME}.tar.gz ."
done

cd /tmp && tar -czf "$ARCHIVE_NAME" "docker_backup_$BACKUP_DATE"

echo "☁️ Enviando backup para S3..."
aws s3 cp "/tmp/$ARCHIVE_NAME" "s3://$BUCKET_NAME/$ARCHIVE_NAME"

echo "🚀 Subindo os containers novamente..."
docker compose up -d

echo "✅ Backup feito e containers restaurados!"
