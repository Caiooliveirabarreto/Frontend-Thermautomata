from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routers.auth import router as auth_router
from routers.artigos import router as artigos_router
from fastapi.staticfiles import StaticFiles

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://127.0.0.1:5500"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
app.include_router(artigos_router)
app.include_router(auth_router)
app.mount("/uploads", StaticFiles(directory="uploads"), name="uploads")

@app.get("/")
def inicio():
    return {"mensagem": "API funcionando"}

