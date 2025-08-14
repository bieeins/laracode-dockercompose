.PHONY: help build up down restart logs shell composer artisan mysql redis clean

# Default target
help: ## Show this help message
	@echo 'Docker Desktop PHP Development Environment'
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@egrep '^(.+)\:\ ##\ (.+)' $(MAKEFILE_LIST) | column -t -c 2 -s ':#'

# Docker operations
build: ## Build all containers
	docker-compose build --no-cache

up: ## Start all services
	docker-compose up -d
	@echo "Services started!"
	@echo "Web: http://localhost:8000"
	@echo "phpMyAdmin: http://localhost:8080"
	@echo "Mailhog: http://localhost:8025"

down: ## Stop all services
	docker-compose down

restart: ## Restart all services
	docker-compose restart

stop: ## Stop all services (alias for down)
	docker-compose stop

# Development
shell: ## Access PHP container shell
	docker-compose exec php bash

logs: ## Show logs for all services
	docker-compose logs -f

logs-php: ## Show PHP logs only
	docker-compose logs -f php

logs-nginx: ## Show Nginx logs only
	docker-compose logs -f webserver

# PHP/Composer operations
composer: ## Run composer install
	docker-compose exec php composer install

composer-update: ## Run composer update
	docker-compose exec php composer update

# Laravel operations
artisan: ## Run artisan command (usage: make artisan cmd="migrate")
	docker-compose exec php php artisan $(cmd)

laravel-install: ## Install fresh Laravel
	docker-compose exec php composer create-project laravel/laravel laravel
	@echo "Laravel installed in src/laravel/"

laravel-key: ## Generate Laravel app key
	docker-compose exec php php laravel/artisan key:generate

# CodeIgniter operations
codeigniter-install: ## Install fresh CodeIgniter
	docker-compose exec php composer create-project codeigniter4/appstarter codeigniter
	@echo "CodeIgniter installed in src/codeigniter/"

# Database operations
# Database operations - UPDATED
mysql: ## Access MySQL shell as appuser
	docker-compose exec mysql mysql -u appuser -p$(shell grep DB_PASSWORD .env | cut -d '=' -f2) $(shell grep DB_DATABASE .env | cut -d '=' -f2)

mysql-root: ## Access MySQL as root
	docker-compose exec mysql mysql -u root -p$(shell grep MYSQL_ROOT_PASSWORD .env | cut -d '=' -f2)

mysql-create-db: ## Create database for Laravel/CodeIgniter
	docker-compose exec mysql mysql -u root -p$(shell grep MYSQL_ROOT_PASSWORD .env | cut -d '=' -f2) -e "CREATE DATABASE IF NOT EXISTS db_laravel; CREATE DATABASE IF NOT EXISTS db_codeigniter; GRANT ALL PRIVILEGES ON db_laravel.* TO 'appuser'@'%'; GRANT ALL PRIVILEGES ON db_codeigniter.* TO 'appuser'@'%'; FLUSH PRIVILEGES;"

mysql-show-dbs: ## Show all databases
	docker-compose exec mysql mysql -u root -p$(shell grep MYSQL_ROOT_PASSWORD .env | cut -d '=' -f2) -e "SHOW DATABASES;"

mysql-show-users: ## Show all users
	docker-compose exec mysql mysql -u root -p$(shell grep MYSQL_ROOT_PASSWORD .env | cut -d '=' -f2) -e "SELECT User, Host FROM mysql.user;"
# mysql: ## Access MySQL shell
# 	docker-compose exec mysql mysql -u root -p$(shell grep DB_PASSWORD .env | cut -d '=' -f2)

# mysql-root: ## Access MySQL as root
# 	docker-compose exec mysql mysql -u root -p

redis: ## Access Redis CLI
	docker-compose exec redis redis-cli

# Utility operations
clean: ## Clean up containers and volumes
	docker-compose down -v
	docker system prune -f

clean-all: ## Clean everything including images
	docker-compose down -v --rmi all
	docker system prune -af

status: ## Show container status
	docker-compose ps

# PHP version switching
php74: ## Switch to PHP 7.4
	@sed -i.bak 's/PHP_VERSION=.*/PHP_VERSION=7.4/' .env
	@echo "Switched to PHP 7.4. Run 'make build && make up' to apply changes."

php80: ## Switch to PHP 8.0
	@sed -i.bak 's/PHP_VERSION=.*/PHP_VERSION=8.0/' .env
	@echo "Switched to PHP 8.0. Run 'make build && make up' to apply changes."

php81: ## Switch to PHP 8.1
	@sed -i.bak 's/PHP_VERSION=.*/PHP_VERSION=8.1/' .env
	@echo "Switched to PHP 8.1. Run 'make build && make up' to apply changes."

php82: ## Switch to PHP 8.2
	@sed -i.bak 's/PHP_VERSION=.*/PHP_VERSION=8.2/' .env
	@echo "Switched to PHP 8.2. Run 'make build && make up' to apply changes."

# Quick setup
setup: ## Quick setup for new project
	@echo "Setting up development environment..."
	make build
	make up
	@echo "Creating src/public directory..."
	@mkdir -p src/public
	@echo "<?php phpinfo(); ?>" > src/public/index.php
	@echo "Setup complete!"
	@echo "Visit: http://localhost:8000"