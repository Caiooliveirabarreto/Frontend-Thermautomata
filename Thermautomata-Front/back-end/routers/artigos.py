from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from models import ArtigosDB, FontesDB, ArtigosFontesDB, TagsDB, ArtigosTagsDB
from schemas import ArtigoCreate, ArtigoResponse
from auth_utils import get_usuario_atual

router = APIRouter(
    prefix="/artigos",
    tags=["Artigos"]
)

@router.post("/criar", response_model=ArtigoResponse)
def criar_artigo(
    artigo: ArtigoCreate,
    db: Session = Depends(get_db),
    usuario=Depends(get_usuario_atual)
):
    if len(artigo.fontes) == 0:
        raise HTTPException(
            status_code=400,
            detail="O artigo precisa ter pelo menos uma fonte"
        )

    ids_tags = set(artigo.tags)
    tags_existentes = db.query(TagsDB).filter(
        TagsDB.idtag.in_(ids_tags)
    ).all()
    if len(tags_existentes) != len(ids_tags):
        raise HTTPException(
            status_code=404,
            detail="Uma ou mais tags não existem"
        )

    novo_artigo = ArtigosDB(
        titulo=artigo.titulo,
        artigo=artigo.artigo,
        iduser=usuario.iduser,
        status="pendente"
    )

    db.add(novo_artigo)
    db.flush()

    for fonte in artigo.fontes:
        nova_fonte = FontesDB(
            nome=fonte.nome,
            link=fonte.link
        )   
        db.add(nova_fonte)
        db.flush()

        relacao = ArtigosFontesDB(
            idart=novo_artigo.idart,
            idfont=nova_fonte.idfont
        )
        db.add(relacao)

        for tag in tags_existentes:
            relacao_tag = ArtigosTagsDB(
                idart=novo_artigo.idart,
                idtag=tag.idtag
            )
            db.add(relacao_tag)
            
    db.commit()

    return novo_artigo

@router.delete("/deletar/{idart}")
def excluir_artigo(
    idart: int,
    db: Session = Depends(get_db),
    usuario=Depends(get_usuario_atual)
):
    artigo = db.query(ArtigosDB).filter(
        ArtigosDB.idart == idart
    ).first()

    if not artigo:
        raise HTTPException(
            status_code=404,
            detail="Artigo não encontrado"
        )

    if artigo.iduser != usuario.iduser and usuario.tipo != 1:
        raise HTTPException(
            status_code=403,
            detail="Você não tem permissão para excluir este artigo"
        )

    db.delete(artigo)
    db.commit()

    return {
        "mensagem": "Artigo excluído com sucesso"
    }