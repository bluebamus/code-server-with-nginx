# Code-Server with Nginx

Nginx 리버스 프록시와 SSL 지원이 포함된 브라우저 기반 VS Code

## 개요

이 프로젝트는 Nginx를 리버스 프록시로 사용하고 SSL/TLS 종료 및 자동 인증서 갱신 기능을 포함하여 브라우저에서 VS Code를 실행할 수 있는 완전한 설정을 제공합니다.

## 기능

- **브라우저 기반 VS Code**: 모든 웹 브라우저에서 접근 가능한 완전한 VS Code 환경
- **SSL/TLS 지원**: Let's Encrypt 인증서를 통한 자동 HTTPS
- **Nginx 리버스 프록시**: 보안 기능이 포함된 프로덕션 준비 웹서버
- **자동 인증서 갱신**: SSL 인증서 자동 갱신을 위한 Cron 작업
- **Docker Compose**: 쉬운 배포 및 관리
- **영구 저장소**: 컨테이너 재시작 시에도 설정과 프로젝트 유지
- **보안 강화**: 보안 헤더, 봇 차단, 파일 접근 제한

## 빠른 시작

1. **저장소 클론 및 설정**
   ```bash
   git clone <repository-url>
   cd code-server-with-nginx
   ```

2. **환경 설정**
   - `docker-compose.yml`을 편집하여 도메인 이름과 비밀번호 업데이트
   - SSL 인증서를 `ssl/letsencrypt/` 디렉토리에 배치
   - `nginx/conf.d/`에서 Nginx 설정 구성

3. **서비스 시작**
   ```bash
   docker-compose up -d
   ```

4. **Code-Server 접속**
   - HTTP: `http://dev.devspoon.com` (HTTPS로 리다이렉트)
   - HTTPS: `https://dev.devspoon.com`

## 디렉토리 구조

```
code-server-with-nginx/
├── config/code-server/      # Code-server 설정 및 환경설정
├── projects/                # 프로젝트 파일 및 워크스페이스
├── nginx/
│   ├── conf.d/             # Nginx 서버 설정
│   ├── nginx_conf/         # 메인 nginx 설정
│   └── proxy_params/       # 프록시 파라미터
├── ssl/
│   ├── certs/              # SSL 인증서
│   └── letsencrypt/        # Let's Encrypt 인증서
├── script/                 # 유틸리티 스크립트
├── backup/                 # 백업 디렉토리
├── logs/nginx/             # Nginx 접근 및 오류 로그
└── docker-compose.yml      # 메인 Docker Compose 설정
```

## 설정

### 환경 변수

`docker-compose.yml`에서 다음 환경 변수들을 설정할 수 있습니다:

- `PUID/PGID`: 파일 권한을 위한 사용자 및 그룹 ID
- `TZ`: 시간대 설정
- `PASSWORD`: code-server 웹 GUI 비밀번호
- `SUDO_PASSWORD`: 터미널 접근을 위한 sudo 비밀번호
- `PROXY_DOMAIN`: 서비스 도메인 이름
- `DEFAULT_WORKSPACE`: 기본 워크스페이스 디렉토리
- `PWA_APPNAME`: Progressive Web App 이름

### SSL 설정

1. **Let's Encrypt 설정**: 인증서를 `ssl/letsencrypt/live/your-domain/`에 배치
2. **사용자 정의 인증서**: `ssl/certs/`에 배치하고 Nginx 설정 업데이트
3. **인증서 갱신**: cron 작업을 통한 자동화 (매일 오전 4시 15분)

### Nginx 설정

여러 설정 파일을 사용할 수 있습니다:

- `nginx/conf.d/code-server.conf`: 기본 HTTP 설정
- `nginx/conf.d/backup/code-server-https.conf`: HTTPS 설정
- `nginx/conf.d/code-server-temp.conf`: 보안이 강화된 설정

## 보안 기능

- **HTTPS 강제**: HTTP에서 HTTPS로 자동 리다이렉트
- **보안 헤더**: HSTS, X-Frame-Options, CSP 등
- **봇 차단**: `bad_bot.conf`를 통한 악성 봇 차단
- **파일 접근 제어**: 민감한 파일에 대한 접근 제한
- **호스트 검증**: 도메인 화이트리스트 보호
- **SSL/TLS 강화**: 최신 암호화 제품군 및 프로토콜

## 백업 및 유지보수

- **코드 백업**: code-server 데이터를 위한 `backup/code/` 디렉토리
- **Nginx 백업**: 웹서버 데이터를 위한 `backup/nginx/` 디렉토리
- **로그 순환**: Docker 로깅 드라이버를 통해 설정
- **헬스 체크**: 컨테이너 상태 모니터링

## 문제 해결

### 일반적인 문제

1. **SSL 인증서 오류**: 인증서가 올바르게 배치되고 경로가 정확한지 확인
2. **권한 문제**: PUID/PGID 설정이 호스트 사용자와 일치하는지 확인
3. **연결 거부**: 방화벽 설정 및 포트 접근성 확인
4. **WebSocket 오류**: Nginx가 WebSocket 지원으로 설정되었는지 확인

### 로그

- **Nginx 로그**: `logs/nginx/access.log` 및 `logs/nginx/error.log`
- **컨테이너 로그**: `docker-compose logs [service_name]`

## 배포 주의사항

- Docker 및 Docker Compose가 설치되어 있는지 확인
- 포트 80과 443을 허용하도록 방화벽 설정
- 도메인에 대한 적절한 DNS 레코드 설정
- 배포 전 비밀번호 및 도메인 이름 업데이트
- 프로덕션 환경에서는 민감한 데이터에 대해 Docker secrets 사용 고려

## 라이선스

이 프로젝트 설정은 교육 및 개발 목적으로 제공됩니다.