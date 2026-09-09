from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from database import get_db
from models import ArtigosDB, FontesDB, ArtigosFontesDB, TagsDB, ArtigosTagsDB, SalvosDB, UsuarioDB
from schemas import ArtigoCreate, ArtigoResponse
from auth_utils import get_usuario_atual
from sqlalchemy import func

router = APIRouter(
    prefix="/artigos",
    tags=["Artigos"]
)

# Rota para criar um novo artigo
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
        fonte_existente = db.query(FontesDB).filter(
            FontesDB.link == fonte.link
        ).first()

        if fonte_existente:
            id_fonte = fonte_existente.idfont
        else:
            nova_fonte = FontesDB(
                link=fonte.link
            )
            db.add(nova_fonte)
            db.flush()

            id_fonte = nova_fonte.idfont

        relacao = ArtigosFontesDB(
            idart=novo_artigo.idart,
            idfont=id_fonte,
            nome=fonte.nome
        )
        db.add(relacao)

    for tag in tags_existentes:
        relacao_tag = ArtigosTagsDB(
            idart=novo_artigo.idart,
            idtag=tag.idtag
        )
        db.add(relacao_tag)
            
    db.commit()

    return {
        "idart": novo_artigo.idart,
        "titulo": novo_artigo.titulo,
        "artigo": novo_artigo.artigo,
        "iduser": novo_artigo.iduser,
        "nome_autor": usuario.nome,
        "status": novo_artigo.status,
        "data_criacao": novo_artigo.data_criacao,
    }

# Rota para excluir um artigo
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

# Rota para salvar um artigo
@router.post("/salvar/{idart}")
def salvar_artigo(
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

    salvo_existente = db.query(SalvosDB).filter(
        SalvosDB.iduser == usuario.iduser,
        SalvosDB.idart == idart
    ).first()

    if salvo_existente:
        raise HTTPException(
            status_code=400,
            detail="Artigo já está salvo"
        )

    novo_salvo = SalvosDB(
        iduser=usuario.iduser,
        idart=idart
    )

    db.add(novo_salvo)
    db.commit()

    return {
        "mensagem": "Artigo salvo com sucesso"
    }

# Rota para remover um artigo salvo
@router.delete("/salvar/{idart}")
def remover_artigo_salvo(
    idart: int,
    db: Session = Depends(get_db),
    usuario=Depends(get_usuario_atual)
):
    salvo = db.query(SalvosDB).filter(
        SalvosDB.iduser == usuario.iduser,
        SalvosDB.idart == idart
    ).first()

    if not salvo:
        raise HTTPException(
            status_code=404,
            detail="Artigo não está salvo"
        )

    db.delete(salvo)
    db.commit()

    return {
        "mensagem": "Artigo removido dos salvos"
    }

# Rota para listar artigos salvos por um usuário
@router.get("/salvos", response_model=list[ArtigoResponse])
def listar_artigos_salvos(
    db: Session = Depends(get_db),
    usuario=Depends(get_usuario_atual)
):
    resultados = db.query(
        ArtigosDB,
        UsuarioDB.nome.label("nome_autor")
    ).join(
        UsuarioDB,
        UsuarioDB.iduser == ArtigosDB.iduser
    ).join(
        SalvosDB,
        SalvosDB.idart == ArtigosDB.idart
    ).filter(
        SalvosDB.iduser == usuario.iduser
    ).all()

    return [
        {
            "idart": artigo.idart,
            "titulo": artigo.titulo,
            "artigo": artigo.artigo,
            "iduser": artigo.iduser,
            "nome_autor": nome_autor,
            "status": artigo.status,
            "data_criacao": artigo.data_criacao,
        }
        for artigo, nome_autor in resultados
    ]

# Rota para aprovar um artigo
@router.put("/aprovar/{idart}")
def aprovar_artigo(
    idart: int,
    db: Session = Depends(get_db),
    usuario=Depends(get_usuario_atual)
):
    if usuario.tipo != 1:
        raise HTTPException(
            status_code=403,
            detail="Apenas administradores podem aprovar artigos"
        )

    artigo = db.query(ArtigosDB).filter(
        ArtigosDB.idart == idart
    ).first()

    if not artigo:
        raise HTTPException(
            status_code=404,
            detail="Artigo não encontrado"
        )

    artigo.status = "aprovado"

    db.commit()

    return {
        "mensagem": "Artigo aprovado com sucesso"
    }

# Rota para rejeitar um artigo
@router.put("/rejeitar/{idart}")
def rejeitar_artigo(
    idart: int,
    db: Session = Depends(get_db),
    usuario=Depends(get_usuario_atual)
):
    if usuario.tipo != 1:
        raise HTTPException(
            status_code=403,
            detail="Apenas administradores podem rejeitar artigos"
        )

    artigo = db.query(ArtigosDB).filter(
        ArtigosDB.idart == idart
    ).first()

    if not artigo:
        raise HTTPException(
            status_code=404,
            detail="Artigo não encontrado"
        )

    artigo.status = "rejeitado"

    db.commit()

    return {
        "mensagem": "Artigo rejeitado com sucesso"
    }

# Rota para listar todas as tags
@router.get("/tags")
def listar_tags(
    db: Session = Depends(get_db)
):
    tags = db.query(TagsDB).all()

    return [
        {
            "idtag": tag.idtag,
            "nome": tag.nome
        }
        for tag in tags
    ]

# Rota para listar artigos com filtros opcionais
@router.get("/", response_model=list[ArtigoResponse])
def listar_artigos(
    autor: str | None = None,
    tags: list[int] | None = Query(None),
    db: Session = Depends(get_db)
):
    consulta = db.query(
        ArtigosDB,
        UsuarioDB.nome.label("nome_autor")
    ).join(
        UsuarioDB,
        UsuarioDB.iduser == ArtigosDB.iduser
    )

    if autor:
        consulta = consulta.filter(
            UsuarioDB.nome == autor
        )

    if tags:
        consulta = consulta.filter(
            ArtigosDB.idart.in_(
                db.query(ArtigosTagsDB.idart)
                .filter(ArtigosTagsDB.idtag.in_(tags))
                .group_by(ArtigosTagsDB.idart)
                .having(func.count(ArtigosTagsDB.idtag) == len(tags))
            )
        )

    resultados = consulta.all()

    return [
        {
            "idart": artigo.idart,
            "titulo": artigo.titulo,
            "artigo": artigo.artigo,
            "iduser": artigo.iduser,
            "nome_autor": nome_autor,
            "status": artigo.status,
            "data_criacao": artigo.data_criacao,
        }
        for artigo, nome_autor in resultados
    ]

# Rota para listar artigos pendentes
@router.get("/pendentes")
def listar_artigos_pendentes(
    db: Session = Depends(get_db),
    usuario=Depends(get_usuario_atual)
):
    if usuario.tipo != 1:
        raise HTTPException(
            status_code=403,
            detail="Acesso permitido apenas para administradores"
        )

    resultados = db.query(
        ArtigosDB,
        UsuarioDB.nome.label("nome_autor")
    ).join(
        UsuarioDB,
        UsuarioDB.iduser == ArtigosDB.iduser
    ).filter(
        ArtigosDB.status == "pendente"
    ).all()

    return [
        {
            "idart": artigo.idart,
            "titulo": artigo.titulo,
            "artigo": artigo.artigo,
            "iduser": artigo.iduser,
            "nome_autor": nome_autor,
            "status": artigo.status,
            "data_criacao": artigo.data_criacao,
        }
        for artigo, nome_autor in resultados
    ]

# Rota para listar artigos de um usuário específico
@router.get("/meus")
def listar_meus_artigos(
    db: Session = Depends(get_db),
    usuario=Depends(get_usuario_atual)
):
    resultados = db.query(
        ArtigosDB,
        UsuarioDB.nome.label("nome_autor")
    ).join(
        UsuarioDB,
        UsuarioDB.iduser == ArtigosDB.iduser
    ).filter(
        ArtigosDB.iduser == usuario.iduser
    ).all()

    return [
        {
            "idart": artigo.idart,
            "titulo": artigo.titulo,
            "artigo": artigo.artigo,
            "iduser": artigo.iduser,
            "nome_autor": nome_autor,
            "status": artigo.status,
            "data_criacao": artigo.data_criacao,
        }
        for artigo, nome_autor in resultados
    ]

# Rota para buscar detalhes de um artigo específico
@router.get("/{idart}/detalhes")
def buscar_detalhes_artigo(
    idart: int,
    db: Session = Depends(get_db)
):
    resultado = db.query(
        ArtigosDB,
        UsuarioDB.nome.label("nome_autor")
    ).join(
        UsuarioDB,
        UsuarioDB.iduser == ArtigosDB.iduser
    ).filter(
        ArtigosDB.idart == idart
    ).first()

    if not resultado:
        raise HTTPException(
            status_code=404,
            detail="Artigo não encontrado"
        )

    artigo, nome_autor = resultado

    fontes = db.query(
        ArtigosFontesDB.nome,
        FontesDB.link
    ).join(
        FontesDB,
        FontesDB.idfont == ArtigosFontesDB.idfont
    ).filter(
        ArtigosFontesDB.idart == idart
    ).all()

    tags = db.query(
        TagsDB.idtag,
        TagsDB.nome
    ).join(
        ArtigosTagsDB,
        ArtigosTagsDB.idtag == TagsDB.idtag
    ).filter(
        ArtigosTagsDB.idart == idart
    ).all()

    return {
        "idart": artigo.idart,
        "titulo": artigo.titulo,
        "artigo": artigo.artigo,
        "iduser": artigo.iduser,
        "nome_autor": nome_autor,
        "status": artigo.status,
        "data_criacao": artigo.data_criacao,

        "fontes": [
            {
                "nome": fonte.nome,
                "link": fonte.link
            }
            for fonte in fontes
        ],

        "tags": [
            {
                "idtag": tag.idtag,
                "nome": tag.nome
            }
            for tag in tags
        ]
    }

# Rota para buscar um artigo específico
@router.get("/{idart}", response_model=ArtigoResponse)
def buscar_artigo(
    idart: int,
    db: Session = Depends(get_db)
):
    resultado = db.query(
        ArtigosDB,
        UsuarioDB.nome.label("nome_autor")
    ).join(
        UsuarioDB,
        UsuarioDB.iduser == ArtigosDB.iduser
    ).filter(
        ArtigosDB.idart == idart
    ).first()

    if not resultado:
        raise HTTPException(
            status_code=404,
            detail="Artigo não encontrado"
        )

    artigo, nome_autor = resultado

    return {
        "idart": artigo.idart,
        "titulo": artigo.titulo,
        "artigo": artigo.artigo,
        "iduser": artigo.iduser,
        "nome_autor": nome_autor,
        "status": artigo.status,
        "data_criacao": artigo.data_criacao,
    }