-- Create databases
CREATE DATABASE IF NOT EXISTS db_laravel;
CREATE DATABASE IF NOT EXISTS db_codeigniter;
CREATE DATABASE IF NOT EXISTS testing;

-- Grant privileges to the regular user (appuser)
-- User 'appuser' sudah dibuat otomatis oleh environment variables
GRANT ALL PRIVILEGES ON laravel.* TO 'appuser'@'%';
GRANT ALL PRIVILEGES ON codeigniter.* TO 'appuser'@'%';
GRANT ALL PRIVILEGES ON testing.* TO 'appuser'@'%';

-- Grant privileges untuk development (optional)
GRANT ALL PRIVILEGES ON *.* TO 'appuser'@'%' WITH GRANT OPTION;

-- Flush privileges
FLUSH PRIVILEGES;

-- Show created databases
SHOW DATABASES;

-- Show users
SELECT User, Host FROM mysql.user WHERE User IN ('root', 'appuser');