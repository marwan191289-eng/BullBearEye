#!/bin/bash
# Quick start script for TradeXray Docker setup (Linux/Mac)

echo "🐳 TradeXray Docker Quick Start"
echo "================================"
echo ""

# Check if .env exists
if [ ! -f .env ]; then
    echo "⚠️  .env file not found. Creating from template..."
    cp .env.example .env
    echo "✅ Created .env file. Please edit it with your API keys and passwords!"
    echo ""
    echo "Required configurations:"
    echo "  - POSTGRES_PASSWORD"
    echo "  - REDIS_PASSWORD"
    echo "  - ETH_RPC_URL"
    echo "  - ETHERSCAN_API_KEY"
    echo ""
    read -p "Press Enter to continue with default values or Ctrl+C to exit and configure"
fi

echo "🚀 Starting Docker containers..."
echo ""

# Start docker compose
docker-compose up -d

echo ""
echo "✅ Services starting up!"
echo ""
echo "Access your services at:"
echo "  Frontend:  http://localhost:3000"
echo "  Backend:   http://localhost:8000"
echo "  API Docs:  http://localhost:8000/docs"
echo ""
echo "Useful commands:"
echo "  View logs:        docker-compose logs -f"
echo "  Stop services:    docker-compose down"
echo "  Restart:          docker-compose restart"
echo ""
echo "📚 For more details, see DOCKER.md"
