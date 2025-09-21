#!/bin/bash
# /usr/local/bin/certbot_renew.sh

LOG_DIR="/var/log/nginx"
LOG_FILE="$LOG_DIR/certbot_$(date +%Y%m%d).log"

# 로그 디렉토리 생성
mkdir -p "$LOG_DIR"

# 실행 시간 로깅
echo "$(date): Starting certbot renewal check..." >> "$LOG_FILE"

# Certbot 갱신 실행
certbot renew --quiet --post-hook "systemctl reload nginx" >> "$LOG_FILE" 2>&1

# 결과 확인
if [ $? -eq 0 ]; then
    echo "$(date): Certbot renewal check completed successfully" >> "$LOG_FILE"
else
    echo "$(date): Certbot renewal check failed with exit code $?" >> "$LOG_FILE"
fi

echo "----------------------------------------" >> "$LOG_FILE"