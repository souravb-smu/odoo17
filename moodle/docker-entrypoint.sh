#!/bin/bash
set -e

# Generate config.php from template using environment variables
envsubst < /var/www/html/config.php.template > /var/www/html/config.php
chown www-data:www-data /var/www/html/config.php

exec "$@"
