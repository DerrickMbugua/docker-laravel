# Use the official PHP image as base
FROM php:8.2-cli

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
  libicu-dev \
  libpq-dev \
  libmcrypt-dev \
  libzip-dev \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  git \
  zip \
  unzip \
  nginx \
  && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
  && docker-php-ext-install \
  gd \
  exif \
  intl \
  pcntl \
  pdo_mysql \
  pdo_pgsql \
  pgsql \
  zip \
  opcache

# Set working directory inside the container
WORKDIR /app

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer



# Copy Laravel application files to the container
COPY . .

# Install Laravel dependencies
RUN composer install --no-dev

# Expose port 8000 (change it if your Laravel app uses a different port)
EXPOSE 8000

# Define the command to run the Laravel application
CMD php artisan serve --host=0.0.0.0 --port=8000