
# BullBearEye - TradeXray: AI Agent Coding Guide

## Project Architecture
- **Backend** (`backend/app/`): FastAPI (Python 3.11), modular APIs (`api/`), business logic/services (`services/`), models (`models/`).
  - AI/ML (PyTorch) in `ai/`, orderbook/whale tracking, on-chain analytics, billing, tenant management.
  - AI signals: `/api/ai.py` runs ML, sends Telegram alerts if confidence > 0.8.
  - WebSocket orderbook/whale tracker starts in `main.py` on app init.
- **Frontend** (`frontend/`): Next.js 13+, TypeScript, Tailwind CSS (RTL), modular components, API integration via `services/api.ts`.
- **Mobile** (`mobile/`): Flutter app, backend API calls via `services/api_service.dart`.
- **Docker**: Compose files for dev/prod, multi-stage builds. See `DOCKER.md` for details.

## Developer Workflows
- **Backend**: `cd backend && pip install -r requirements.txt && uvicorn app.main:app --reload`
- **Frontend**: `cd frontend && npm install && npm run dev`
- **Full Stack (Docker)**: `docker-compose up --build` (dev), `docker-compose -f docker-compose.prod.yml up -d --build` (prod)
- **Environment**: Copy `.env.example` or `.env.prod.example` and set secrets/API keys before running. `docker-start.ps1` auto-creates `.env` if missing.
- **CI/CD**: GitHub Actions deploy via SSH (`.github/workflows/deploy.yml`).

## Project Conventions & Patterns
- **API boundaries**: All backend APIs in `app/api/`; services in `app/services/`; models in `app/models/`.
- **AI signals**: Always return prediction + confidence; send Telegram alert if confidence > 0.8.
- **Explainability**: Signals include reason (technical, liquidity, whales, on-chain, AI).
- **Frontend**: Use `NEXT_PUBLIC_API_URL` for backend endpoint; RTL and Arabic localization throughout.
- **Compliance**: No financial advice, clear demo/live separation, all signals logged for audit (`compliance/page.tsx`).
- **Docker**: Hot-reload in dev via volume mounts; standalone images in prod. See `DOCKER.md` for build logic.

## Integration Points
- **External APIs**: Binance, Etherscan, Infura, Alchemy (API keys required).
- **Telegram**: Alerts via `services/telegram.py`.
- **Database/Cache**: PostgreSQL/Redis via `.env` and Docker Compose.

## Key Files & Directories
- `backend/app/api/ai.py` – AI prediction endpoint
- `backend/app/main.py` – FastAPI app entry, service startup
- `frontend/services/api.ts` – API calls from frontend
- `DOCKER.md` – Architecture, build, deployment, troubleshooting
- `.env.example`, `.env.prod.example` – Environment variable templates
- `.github/workflows/deploy.yml` – CI/CD deployment

## Examples
- **AI prediction API**:
  ```python
  @router.get("/predict")
  def ai_prediction(symbol="BTC/USDT"):
      # ... fetch data, run ML, send alert if confidence > 0.8
  ```
- **Frontend API usage**:
  ```ts
  // services/api.ts
  export async function getPrediction(symbol: string) {
    return fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/ai/predict?symbol=${symbol}`)
  }
  ```
- **Docker Compose**:
  ```yaml
  services:
    backend:
      build: ./backend
      environment:
        ETHERSCAN_API_KEY: ${ETHERSCAN_API_KEY}
        ...
      command: uvicorn app.main:app --reload
  ```

---
**Feedback requested:**
- If any section is unclear, incomplete, or missing project-specific details, please comment for improvement.
