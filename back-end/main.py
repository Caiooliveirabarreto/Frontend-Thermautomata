from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routers.auth import router as auth_router
from routers.artigos import router as artigos_router
from fastapi.staticfiles import StaticFiles
from routers.usuarios import router as usuarios_router
from pathlib import Path
import os
from dotenv import load_dotenv

app = FastAPI()

BASE_DIR = Path(__file__).resolve().parent

# Carrega as variáveis de ambiente do backend.
load_dotenv(BASE_DIR / ".env")

UPLOADS_DIR = BASE_DIR / "uploads"

# Origens autorizadas a acessar a API.
origens_permitidas = [
    "http://127.0.0.1:5500",
    "http://localhost:5500",
]

# Adiciona o domínio do frontend quando estiver hospedado.
FRONTEND_URL = os.getenv("FRONTEND_URL")

if FRONTEND_URL:
    origens_permitidas.append(FRONTEND_URL.rstrip("/"))

# Configuração do CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=origens_permitidas,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(artigos_router)
app.include_router(auth_router)
app.include_router(usuarios_router)

UPLOADS_DIR.mkdir(exist_ok=True)

app.mount("/uploads", StaticFiles(directory=str(UPLOADS_DIR)), name="uploads")

@app.get("/")
def inicio():
    return {"mensagem": "API funcionando"}