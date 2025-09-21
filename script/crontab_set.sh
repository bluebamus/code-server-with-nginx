#!/bin/bash

echo "15 4 * * * root /usr/local/bin/certbot_renew.sh" >> /etc/crontab
