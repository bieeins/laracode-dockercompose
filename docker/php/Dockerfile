ARG PHP_VERSION=8.2
FROM php:${PHP_VERSION}-fpm

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libgd-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libicu-dev \
    libxslt-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libpq-dev \
    libsqlite3-dev \
    zip \
    unzip \
    vim \
    nano \
    htop \
    jpegoptim \
    optipng \
    pngquant \
    gifsicle \
    pkg-config \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configure PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure intl \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql

# Install PHP extensions
RUN docker-php-ext-install -j$(nproc) \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pdo_sqlite \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    zip \
    intl \
    soap \
    xsl \
    opcache \
    sockets \
    mysqli \
    calendar \
    gettext

# Install PECL extensions
RUN pecl install redis \
    && docker-php-ext-enable redis

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install Node.js (for asset compilation)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Create system user
RUN groupadd -g 1000 www \
    && useradd -u 1000 -ms /bin/bash -g www www

# Set permissions
RUN chown -R www:www /var/www/html

# Switch to www user
USER www

# Expose port 9000
EXPOSE 9000

CMD ["php-fpm"]