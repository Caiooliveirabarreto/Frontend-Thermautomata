from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import func

from database import get_db
from models import UsuarioDB, ArtigosDB


router = APIRouter(
    prefix="/usuarios",
    tags=["Usuários"]
)


# Busca as informações públicas de um perfil.
@router.get("/{iduser}/perfil")
def buscar_perfil(
    iduser: int,
    db: Session = Depends(get_db)
):
    usuario = db.query(UsuarioDB).filter(
        UsuarioDB.iduser == iduser
    ).first()

    if not usuario:
        raise HTTPException(
            status_code=404,
            detail="Usuário não encontrado"
        )

    total_artigos = db.query(ArtigosDB).filter(
        ArtigosDB.iduser == iduser,
        ArtigosDB.status == "aprovado"
    ).count()

    return {
        "iduser": usuario.iduser,
        "nome": usuario.nome,
        "foto_perfil": usuario.foto_perfil,
        "total_artigos": total_artigos
    }


# Lista somente os artigos publicados de um usuário.
@router.get("/{iduser}/artigos")
def listar_artigos_usuario(
    iduser: int,
    db: Session = Depends(get_db)
):
    usuario = db.query(UsuarioDB).filter(
        UsuarioDB.iduser == iduser
    ).first()

    if not usuario:
        raise HTTPException(
            status_code=404,
            detail="Usuário não encontrado"
        )

    artigos = db.query(ArtigosDB).filter(
        ArtigosDB.iduser == iduser,
        ArtigosDB.status == "aprovado"
    ).order_by(
        func.coalesce(
            ArtigosDB.data_publicacao,
            ArtigosDB.data_criacao
        ).desc()
    ).all()

    return [
        {
            "idart": artigo.idart,
            "titulo": artigo.titulo,
            "resumo": (
                artigo.artigo[:180] + "..."
                if len(artigo.artigo) > 180
                else artigo.artigo
            ),
            "iduser": artigo.iduser,
            "nome_autor": usuario.nome,
            "status": artigo.status,
            "data_criacao": artigo.data_criacao,
            "data_publicacao": (
                artigo.data_publicacao or artigo.data_criacao
            )
        }
        for artigo in artigos
    ]