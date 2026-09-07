from fastapi import FastAPI
from routers.auth import router as auth_router
from routers.artigos import router as artigos_router

app = FastAPI()

app.include_router(artigos_router)
app.include_router(auth_router)

@app.get("/")
def inicio():
    return {"mensagem": "API funcionando"}

