@echo off
REM Backend initialization script for Windows

echo.
echo 🚀 Initializing Medusa Backend...
echo.

REM Check if pnpm is installed
where pnpm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ pnpm is not installed. Installing...
    call npm install -g pnpm@9.10.0
)

REM Install dependencies
echo 📦 Installing dependencies...
call pnpm install

REM Run migrations
echo 🗄️  Running database migrations...
call pnpm medusa db:migrate

echo.
echo ✅ Backend initialization complete!
echo 💡 Run 'pnpm dev' to start development server
echo.
pause
