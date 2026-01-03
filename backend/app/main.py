from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api import market, signals, orderbook, whales, onchain, ai
from app.services.orderbook import start_orderbook, orderbook_data
from app.services.whale_tracker import start_whale_tracker


app = FastAPI(title="Crypto Intelligence Platform")


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Start Binance orderbook WebSocket on startup
import threading
import os
try:
    from dotenv import load_dotenv
    # Try loading .env from backend and app directories
    env_paths = [
        os.path.join(os.path.dirname(__file__), '..', '.env'),
        os.path.join(os.path.dirname(__file__), '.env'),
        os.path.join(os.getcwd(), '.env')
    ]
    for env_path in env_paths:
        if os.path.exists(env_path):
            load_dotenv(dotenv_path=env_path, override=True)
except ImportError:
    pass  # dotenv not installed, skip

## تم تعطيل WebSocket الخاص بالحيتان وorderbook مؤقتًا لعرض النظام فقط
#@app.on_event("startup")
#def startup():
#    threading.Thread(target=start_orderbook, daemon=True).start()
#    threading.Thread(target=start_whale_tracker, daemon=True).start()







from app.api import tenant
app.include_router(market.router, prefix="/market")
app.include_router(signals.router, prefix="/signals")
app.include_router(orderbook.router, prefix="/orderbook")
app.include_router(whales.router, prefix="/whales")
app.include_router(onchain.router, prefix="/onchain")
app.include_router(ai.router, prefix="/ai")
app.include_router(tenant.router)


@app.get("/")
def root():
    return {"status": "running"}


@app.get("/health")
def health():
    """Health check endpoint for Docker"""
    return {"status": "healthy", "service": "backend"}
