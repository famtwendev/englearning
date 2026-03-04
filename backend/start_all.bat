@echo off
echo ===================================================
echo Checking required ports (8080, 8081, 8082)...
echo ===================================================

:: Check Port 8081 (Identity Service)
netstat -ano | findstr ":8081 " >nul
if %errorlevel% equ 0 (
    echo [ERROR] Port 8081 is already in use! Cannot start Identity Service.
    goto :portInUse
)

:: Check Port 8082 (Core Learning Service)
netstat -ano | findstr ":8082 " >nul
if %errorlevel% equ 0 (
    echo [ERROR] Port 8082 is already in use! Cannot start Core Learning Service.
    goto :portInUse
)

:: Check Port 8080 (API Gateway)
netstat -ano | findstr ":8080 " >nul
if %errorlevel% equ 0 (
    echo [ERROR] Port 8080 is already in use! Cannot start API Gateway.
    goto :portInUse
)

echo All ports are available. Starting the system...
echo.

echo 1. Starting Identity Service (Port 8081)...
start "Identity Service" cmd /k "java -jar identity-service\target\identity-service-1.0.0-SNAPSHOT.jar"

echo 2. Starting Core Learning Service (Port 8082)...
start "Core Learning Service" cmd /k "java -jar core-learning-service\target\core-learning-service-1.0.0-SNAPSHOT.jar"

echo 3. Starting API Gateway (Port 8080)...
start "API Gateway" cmd /k "java -jar api-gateway\target\api-gateway-1.0.0-SNAPSHOT.jar"

echo.
echo All started! Please see separate command windows for logs.
echo Press any key to exit this launcher...
pause >nul
exit /b

:portInUse
echo.
echo ===================================================
echo LAUNCHER STOPPED.
echo Please terminate the process using the port and try again.
echo ===================================================
pause
exit /b