@echo off

REM === Backend ===
cd backend
pip install -r requirements.txt
start "FastAPI" uvicorn app.main:app
cd ..

REM === Frontend ===
cd frontend
call npm install
start "Next.js" npm run dev
cd ..

echo Project started! Backend on http://localhost:8000, Frontend on http://localhost:3000
pause
