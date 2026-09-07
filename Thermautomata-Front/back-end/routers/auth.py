from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from database import get_db
from models import UsuarioDB
from schemas import UsuarioCreate, UsuarioResponse, UsuarioLogin
from pwdlib import PasswordHash
from auth_utils import criar_token, get_usuario_atual

password_hash = PasswordHash.recommended()

router = APIRouter(
    prefix="/auth",
    tags=["Autenticação"]
)

# Endpoint para cadastro de usuário
@router.post("/cadastro", response_model=UsuarioResponse)
def cadastrar_usuario(usuario: UsuarioCreate, db: Session = Depends(get_db)):
    # Verifica se o email já está cadastrado
    usuario_existente = db.query(UsuarioDB).filter(UsuarioDB.email == usuario.email).first()
    if usuario_existente:
        raise HTTPException(status_code=400, detail="Email já cadastrado")

    # Cria um novo usuário
    novo_usuario = UsuarioDB(
        nome=usuario.nome,
        email=usuario.email,
        senha=password_hash.hash(usuario.senha),
        tipo=0,  # Tipo padrão para usuário comum
        foto_perfil=usuario.foto_perfil or "template-perfil.jpg"
    )
    db.add(novo_usuario)
    db.commit()
    db.refresh(novo_usuario)

    return novo_usuario

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