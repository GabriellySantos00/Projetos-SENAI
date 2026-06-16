import mysql.connector

def conectar():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="dev@2025",
        database="diario_filmes"
    )