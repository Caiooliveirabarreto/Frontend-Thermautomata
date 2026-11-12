import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from dotenv import load_dotenv
from pathlib import Path

# Formato: mysql+pymysql://usuario:@host/nome_do_banco

# Localização do backend
BASE_DIR = Path(__file__).resolve().parent

# Carrega as variáveis de ambiente do arquivo .env localizado no backend
load_dotenv(BASE_DIR / ".env")

# URL de conexão com o banco
DATABASE_URL = os.getenv("DATABASE_URL")

if not DATABASE_URL:
    raise ValueError("A variável de ambiente DATABASE_URL não está definida.")

# Configuração do SQLAlchemy
engine = create_engine(DATABASE_URL)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Função de dependência: abre uma sessão por requisição e garante o fechamento
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()