from sqlalchemy import Column, Integer, String, Text, DateTime
from database import Base
from sqlalchemy import func, ForeignKey

class UsuarioDB(Base):
    __tablename__ = 'usuario'
    iduser = Column(Integer, primary_key=True, index=True)
    nome = Column(String(50), nullable=False)
    email = Column(String(255), nullable=False, unique=True)
    senha = Column(String(255), nullable=False)
    tipo = Column(Integer, nullable=False)  # 0 para usuário comum, 1 para administrador
    foto_perfil = Column(String(255), nullable=False, default="template-perfil.jpg")

class ArtigosDB(Base):
    __tablename__ = 'artigos'
    idart = Column(Integer, primary_key=True, index=True)
    titulo = Column(String(255), nullable=False)
    artigo = Column(Text, nullable=False)
    iduser = Column(Integer, ForeignKey("usuario.iduser"), nullable=False)  # ID do usuário que criou o artigo
    status = Column(String(20), nullable=False, default="pendente")  # Status do artigo: pendente, aprovado, reprovado
    data_criacao = Column(DateTime, nullable=False, server_default=func.current_timestamp())  # Data de criação do artigo
    data_atualizacao = Column(DateTime, nullable=True, server_default=func.current_timestamp(), onupdate=func.current_timestamp()) # Data de atualização do artigo

class FontesDB(Base):
    __tablename__ = 'fontes'
    idfont = Column(Integer, primary_key=True, index=True)
    nome = Column(String(255), nullable=False)
    link = Column(String(255), nullable=False)

class ArtigosFontesDB(Base):
    __tablename__ = 'artigos_fontes'
    idart = Column(Integer, ForeignKey("artigos.idart"), primary_key=True)
    idfont = Column(Integer, ForeignKey("fontes.idfont"), primary_key=True)

class TagsDB(Base):
    __tablename__ = 'tags'
    idtag = Column(Integer, primary_key=True, index=True)
    nome = Column(String(100), nullable=False, unique=True)

class ArtigosTagsDB(Base):
    __tablename__ = 'artigos_tags'
    idart = Column(Integer, ForeignKey("artigos.idart"), primary_key=True)
    idtag = Column(Integer, ForeignKey("tags.idtag"), primary_key=True)