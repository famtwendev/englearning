param(
    [string]$File = "mental_and_physical_development.json"
)

if (-Not (Test-Path $File)) {
    Write-Host "ERROR: File '$File' not found!" -ForegroundColor Red
    exit
}

Write-Host "Authenticating with Admin credentials..." -ForegroundColor Cyan
$authBody = '{"email":"admin@system.com","password":"Admin@123"}'

# Execute login using curl.exe
$loginOutput = curl.exe -s -X POST "http://localhost:8080/api/v1/auth/authenticate" `
    -H "Content-Type: application/json" `
    -d $authBody

# Extract token using Regex to avoid json parsing complexity differences
if ($loginOutput -match '"token"\s*:\s*"([^"]+)"') {
    $token = $matches[1]
    Write-Host "Authentication Successful." -ForegroundColor Green
} else {
    Write-Host "Failed to authenticate or extract token!" -ForegroundColor Red
    Write-Host "Response: $loginOutput"
    exit
}

Write-Host "Importing JSON data from [$File]..." -ForegroundColor Cyan

# Perform import using curl.exe to avoid PowerShell UTF-8 payload corruption
$importOutput = curl.exe -s -X POST "http://localhost:8080/api/v1/topics/import/json" `
    -H "Content-Type: application/json" `
    -H "Authorization: Bearer $token" `
    -d "@$File"

Write-Host ""
Write-Host "------------- SERVER RESPONSE -------------" -ForegroundColor Yellow
Write-Host $importOutput
Write-Host "-------------------------------------------" -ForegroundColor Yellow
