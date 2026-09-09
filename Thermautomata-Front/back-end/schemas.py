from pydantic import BaseModel, Field
from datetime import datetime

# Schemas para o usuário
class UsuarioBase(BaseModel):
    nome: str
    email: str

class UsuarioCreate(UsuarioBase):
    senha: str

class UsuarioResponse(UsuarioBase):
    iduser: int
    tipo: int
    foto_perfil: str
    token: str | None = None

    model_config = {
        "from_attributes": True
    }

class UsuarioLogin(BaseModel):
    email: str
    senha: str

class FonteCreate(BaseModel):
    nome: str
    link: str

class ArtigoCreate(BaseModel):
    titulo: str
    artigo: str
    fontes: list[FonteCreate]
    tags: list[int] = Field(min_length=1)

class ArtigoResponse(BaseModel):
    idart: int
    titulo: str
    artigo: str
    iduser: int
    nome_autor: str
    status: str
    data_criacao: datetime

    model_config = {
        "from_attributes": True
    }