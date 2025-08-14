@echo off
echo Starting Docker Desktop PHP Environment...
docker-compose up -d
echo.
echo Services started!
echo Web: http://localhost:8000
echo phpMyAdmin: http://localhost:8080
echo Mailhog: http://localhost:8025
pause