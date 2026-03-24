FROM php:8.2-apache

# ─── System dependencies & PHP extensions ────────────────────────────────────
RUN apt-get update && apt-get install -y \
        libpng-dev libjpeg-dev libwebp-dev libfreetype6-dev \
        libzip-dev libxml2-dev libicu-dev libonig-dev \
        libxslt-dev libldap2-dev gettext-base curl \
    && docker-php-ext-configure gd \
            --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) \
            gd intl mbstring soap zip opcache xsl \
            pdo pdo_mysql mysqli exif \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/*

# ─── PHP tuning for Moodle ────────────────────────────────────────────────────
RUN { \
        echo 'upload_max_filesize = 100M'; \
        echo 'post_max_size = 110M'; \
        echo 'max_input_vars = 5000'; \
        echo 'max_execution_time = 360'; \
        echo 'opcache.enable = 1'; \
    } >> /usr/local/etc/php/php.ini

# ─── Download Moodle 5.1.3 ───────────────────────────────────────────────────
RUN curl -fsSL \
        "https://download.moodle.org/download.php/direct/stable501/moodle-5.1.3.tgz" \
    | tar -xz -C /var/www/html --strip-components=1 \
    && chown -R www-data:www-data /var/www/html

# ─── Moodle data directory ────────────────────────────────────────────────────
RUN mkdir -p /var/www/moodledata \
    && chown www-data:www-data /var/www/moodledata

# ─── Config template + entrypoint ────────────────────────────────────────────
COPY config.php.template /var/www/html/config.php.template
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
