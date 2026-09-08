from fastapi import APIRouter, HTTPException, Depends, Form, UploadFile, File
from sqlalchemy.orm import Session
from database import get_db
from models import UsuarioDB
from schemas import UsuarioCreate, UsuarioResponse, UsuarioLogin
from pwdlib import PasswordHash
from auth_utils import criar_token, get_usuario_atual
from pathlib import Path
import os
import uuid

password_hash = PasswordHash.recommended()

router = APIRouter(
    prefix="/auth",
    tags=["Autenticação"]
)
PASTA_FOTOS = Path("uploads/perfis")
PASTA_FOTOS.mkdir(parents=True, exist_ok=True)

# Endpoint para cadastro de usuário
@router.post("/cadastro", response_model=UsuarioResponse)
def cadastrar_usuario(
    nome: str = Form(...),
    email: str = Form(...),
    senha: str = Form(...),
    foto_perfil: UploadFile | None = File(None),
    db: Session = Depends(get_db)
):

    # Verifica se o email já está cadastrado
    usuario_existente = db.query(UsuarioDB).filter(
        UsuarioDB.email == email
    ).first()

    if usuario_existente:
        raise HTTPException(
            status_code=400,
            detail="Email já cadastrado"
        )

    usuario_nome_existente = db.query(UsuarioDB).filter(
        UsuarioDB.nome == nome
    ).first()

    # Verifica se o nome de usuário já está sendo usado
    if usuario_nome_existente:
        raise HTTPException(
            status_code=400,
            detail="Este nome de usuário já está sendo usado."
        )

    nome_foto = "template-perfil.jpg"

    if foto_perfil:
        extensao = Path(foto_perfil.filename).suffix
        nome_foto = f"{uuid.uuid4()}{extensao}"

        caminho_foto = PASTA_FOTOS / nome_foto

        with open(caminho_foto, "wb") as arquivo:
            arquivo.write(foto_perfil.file.read())

    # Cria um novo usuário
    novo_usuario = UsuarioDB(
        nome=nome,
        email=email,
        senha=password_hash.hash(senha),
        tipo=0,
        foto_perfil=nome_foto
    )

    db.add(novo_usuario)
    db.commit()
    db.refresh(novo_usuario)

    token = criar_token(novo_usuario.iduser)

    return {
        "iduser": novo_usuario.iduser,
        "nome": novo_usuario.nome,
        "email": novo_usuario.email,
        "tipo": novo_usuario.tipo,
        "foto_perfil": novo_usuario.foto_perfil,
        "token": token
    }

# Endpoint para login de usuário
@router.post("/login", response_model=UsuarioResponse)
def login_usuario(usuario: UsuarioLogin, db: Session = Depends(get_db)):
    # Verifica se o email existe
    usuario_existente = db.query(UsuarioDB).filter(UsuarioDB.email == usuario.email).first()
    if not usuario_existente:
        raise HTTPException(status_code=400, detail="Email ou senha incorretos")

    # Verifica a senha
    if not password_hash.verify(usuario.senha, usuario_existente.senha):
        raise HTTPException(status_code=400, detail="Email ou senha incorretos")

    # Cria um token JWT para o usuário
    token = criar_token(usuario_existente.iduser)
    
    # Monta a resposta com os dados do usuário e o token
    resposta = UsuarioResponse(
        iduser=usuario_existente.iduser,
        nome=usuario_existente.nome,
        email=usuario_existente.email,
        foto_perfil=usuario_existente.foto_perfil,
        tipo=usuario_existente.tipo,
        token=token
    )

    return resposta

@router.get("/me", response_model=UsuarioResponse)
def usuario_atual(usuario = Depends(get_usuario_atual)):
    return usuario