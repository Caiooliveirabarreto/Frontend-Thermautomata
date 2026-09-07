import os

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from dotenv import load_dotenv

# Formato: mysql+pymysql://usuario:@host/nome_do_banco

load_dotenv()  # Carrega as variáveis de ambiente do arquivo .env

DATABASE_URL = os.getenv("DATABASE_URL")
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