# Code-Server with Nginx

VS Code in the browser powered by code-server with Nginx reverse proxy and SSL support.

## Overview

This project provides a complete setup for running VS Code in your browser using code-server with Nginx as a reverse proxy, SSL/TLS termination, and automated certificate renewal.

## Features

- **VS Code in Browser**: Full VS Code experience accessible from any web browser
- **SSL/TLS Support**: Automatic HTTPS with Let's Encrypt certificates
- **Nginx Reverse Proxy**: Production-ready web server with security features
- **Automated Certificate Renewal**: Cron job for automatic SSL certificate renewal
- **Docker Compose**: Easy deployment and management
- **Persistent Storage**: Configurations and projects persist across container restarts
- **Security Hardened**: Security headers, bot protection, and file access restrictions

## Quick Start

1. **Clone and Setup**
   ```bash
   git clone <repository-url>
   cd code-server-with-nginx
   ```

2. **Configure Environment**
   - Edit `docker-compose.yml` and update domain names and passwords
   - Place SSL certificates in `ssl/letsencrypt/` directory
   - Configure Nginx settings in `nginx/conf.d/`

3. **Start Services**
   ```bash
   docker-compose up -d
   ```

4. **Access Code-Server**
   - HTTP: `http://dev.devspoon.com` (redirects to HTTPS)
   - HTTPS: `https://dev.devspoon.com`

## Directory Structure

```
code-server-with-nginx/
├── config/code-server/      # Code-server configuration and settings
├── projects/                # Project files and workspaces
├── nginx/
│   ├── conf.d/             # Nginx server configurations
│   ├── nginx_conf/         # Main nginx configuration
│   └── proxy_params/       # Proxy parameters
├── ssl/
│   ├── certs/              # SSL certificates
│   └── letsencrypt/        # Let's Encrypt certificates
├── script/                 # Utility scripts
├── backup/                 # Backup directories
├── logs/nginx/             # Nginx access and error logs
└── docker-compose.yml      # Main Docker Compose configuration
```

## Configuration

### Environment Variables

The following environment variables can be configured in `docker-compose.yml`:

- `PUID/PGID`: User and group IDs for file permissions
- `TZ`: Timezone setting
- `PASSWORD`: Web GUI password for code-server
- `SUDO_PASSWORD`: Sudo password for terminal access
- `PROXY_DOMAIN`: Domain name for the service
- `DEFAULT_WORKSPACE`: Default workspace directory
- `PWA_APPNAME`: Progressive Web App name

### SSL Configuration

1. **Let's Encrypt Setup**: Place certificates in `ssl/letsencrypt/live/your-domain/`
2. **Custom Certificates**: Place in `ssl/certs/` and update Nginx configuration
3. **Certificate Renewal**: Automated via cron job (daily at 4:15 AM)

### Nginx Configuration

Multiple configuration files are available:

- `nginx/conf.d/code-server.conf`: Basic HTTP configuration
- `nginx/conf.d/backup/code-server-https.conf`: HTTPS configuration
- `nginx/conf.d/code-server-temp.conf`: Enhanced configuration with security

## Security Features

- **HTTPS Enforcement**: Automatic HTTP to HTTPS redirection
- **Security Headers**: HSTS, X-Frame-Options, CSP, etc.
- **Bot Protection**: Bad bot blocking via `bad_bot.conf`
- **File Access Control**: Restricted access to sensitive files
- **Host Validation**: Domain whitelist protection
- **SSL/TLS Hardening**: Modern cipher suites and protocols

## Backup and Maintenance

- **Code Backup**: `backup/code/` directory for code-server data
- **Nginx Backup**: `backup/nginx/` directory for web server data
- **Log Rotation**: Configured through Docker logging drivers
- **Health Checks**: Container health monitoring

## Troubleshooting

### Common Issues

1. **SSL Certificate Errors**: Ensure certificates are properly placed and paths are correct
2. **Permission Issues**: Check PUID/PGID settings match your host user
3. **Connection Refused**: Verify firewall settings and port accessibility
4. **WebSocket Errors**: Ensure Nginx is configured with WebSocket support

### Logs

- **Nginx Logs**: `logs/nginx/access.log` and `logs/nginx/error.log`
- **Container Logs**: `docker-compose logs [service_name]`

## Deployment Notes

- Ensure Docker and Docker Compose are installed
- Configure firewall to allow ports 80 and 443
- Set appropriate DNS records for your domain
- Update passwords and domain names before deployment
- Consider using Docker secrets for sensitive data in production

## License

This project configuration is provided as-is for educational and development purposes.