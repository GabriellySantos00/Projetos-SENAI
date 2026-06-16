from flask import Flask, render_template, request, jsonify
import mysql.connector

app = Flask(__name__)

def conectar():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="dev@2025",
        database="midnight_racer"
    )

@app.route("/")
def index():
    conexao = conectar()
    cursor = conexao.cursor(dictionary=True)

    cursor.execute("SELECT * FROM ranking ORDER BY pontos DESC LIMIT 5")
    ranking = cursor.fetchall()

    cursor.close()
    conexao.close()

    return render_template("index.html", ranking=ranking)

@app.route("/salvar", methods=["POST"])
def salvar():
    dados = request.get_json()

    nome = dados["nome"]
    pontos = dados["pontos"]

    conexao = conectar()
    cursor = conexao.cursor()

    cursor.execute(
        "INSERT INTO ranking (nome, pontos) VALUES (%s, %s)",
        (nome, pontos)
    )

    conexao.commit()
    cursor.close()
    conexao.close()

    return jsonify({"mensagem": "salvo"})

if __name__ == "__main__":
    app.run(debug=True)