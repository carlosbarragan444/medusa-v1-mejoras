#!/bin/bash

# Backend initialization script for Linux/macOS

echo ""
echo "🚀 Initializing Medusa Backend..."
echo ""

# Check if pnpm is installed
if ! command -v pnpm &> /dev/null; then
    echo "❌ pnpm is not installed. Installing..."
    npm install -g pnpm@9.10.0
fi

# Install dependencies
echo "📦 Installing dependencies..."
pnpm install

# Run migrations
echo "🗄️  Running database migrations..."
pnpm medusa db:migrate

echo ""
echo "✅ Backend initialization complete!"
echo "💡 Run 'pnpm dev' to start development server"
echo ""
