import jwt
import os

from fastapi import HTTPException, Depends
from models import UsuarioDB
from sqlalchemy.orm import Session
from fastapi.security import HTTPBearer
from database import get_db
from dotenv import load_dotenv
from datetime import datetime, timedelta

load_dotenv()  # Carrega as variáveis de ambiente do arquivo .env

SECRET_KEY = os.getenv("SECRET_KEY")
ALGORITHM = "HS256"
security = HTTPBearer()


def criar_token(id_usuario):
    expiracao = datetime.utcnow() + timedelta(hours=12)  # Define a expiração do token para 12 horas
    payload = {"sub": str(id_usuario), "exp": expiracao}
    token = jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)
    return token

def verificar_token(token):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload["sub"]
    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Token expirado")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Token inválido")

def get_usuario_atual(credenciais = Depends(security), db: Session = Depends(get_db)):
    token = credenciais.credentials
    id_usuario = verificar_token(token)
    usuario = db.query(UsuarioDB).filter(
        UsuarioDB.iduser == id_usuario
    ).first()
    if not usuario:
        raise HTTPException(status_code=404, detail="Usuário não encontrado")

    return usuario