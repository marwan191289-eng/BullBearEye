#!/usr/bin/env pwsh
# Quick start script for TradeXray Docker setup

Write-Host "🐳 TradeXray Docker Quick Start" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Check if .env exists
if (-not (Test-Path ".env")) {
    Write-Host "⚠️  .env file not found. Creating from template..." -ForegroundColor Yellow
    Copy-Item .env.example .env
    Write-Host "✅ Created .env file. Please edit it with your API keys and passwords!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Required configurations:" -ForegroundColor Yellow
    Write-Host "  - POSTGRES_PASSWORD" -ForegroundColor White
    Write-Host "  - REDIS_PASSWORD" -ForegroundColor White
    Write-Host "  - ETH_RPC_URL" -ForegroundColor White
    Write-Host "  - ETHERSCAN_API_KEY" -ForegroundColor White
    Write-Host ""
    $continue = Read-Host "Press Enter to continue with default values or Ctrl+C to exit and configure"
}

Write-Host "🚀 Starting Docker containers..." -ForegroundColor Green
Write-Host ""

# Start docker compose
docker-compose up -d

Write-Host ""
Write-Host "✅ Services starting up!" -ForegroundColor Green
Write-Host ""
Write-Host "Access your services at:" -ForegroundColor Cyan
Write-Host "  Frontend:  http://localhost:3000" -ForegroundColor White
Write-Host "  Backend:   http://localhost:8000" -ForegroundColor White
Write-Host "  API Docs:  http://localhost:8000/docs" -ForegroundColor White
Write-Host ""
Write-Host "Useful commands:" -ForegroundColor Cyan
Write-Host "  View logs:        docker-compose logs -f" -ForegroundColor White
Write-Host "  Stop services:    docker-compose down" -ForegroundColor White
Write-Host "  Restart:          docker-compose restart" -ForegroundColor White
Write-Host ""
<<<<<<< HEAD
Write-Host "📚 For more details, see DOCKER.md" -ForegroundColor Yellow
=======
Write-Host "📚 For more details, see DOCKER.md" -ForegroundColor Yellow
>>>>>>> 9110944d30265696062aafd3ebe1ba536af1f08a
