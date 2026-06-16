from flask import Flask, render_template, request, redirect, url_for
from db import conectar

app = Flask(__name__)

@app.route("/")
def index():
    conexao = conectar()
    cursor = conexao.cursor(dictionary=True)

    cursor.execute("SELECT * FROM filmes")
    filmes = cursor.fetchall()

    cursor.close()
    conexao.close()

    return render_template("index.html", filmes=filmes)

@app.route("/cadastrar", methods=["GET", "POST"])
def cadastrar():
    if request.method == "POST":
        nome = request.form["nome"]
        genero = request.form["genero"]
        plataforma = request.form["plataforma"]
        status = request.form["status"]
        nota = request.form["nota"]
        comentario = request.form["comentario"]

        conexao = conectar()
        cursor = conexao.cursor()

        sql = """
        INSERT INTO filmes (nome, genero, plataforma, status, nota, comentario)
        VALUES (%s, %s, %s, %s, %s, %s)
        """

        valores = (nome, genero, plataforma, status, nota, comentario)

        cursor.execute(sql, valores)
        conexao.commit()

        cursor.close()
        conexao.close()

        return redirect(url_for("index"))

    return render_template("cadastrar.html")

@app.route("/editar/<int:id>", methods=["GET", "POST"])
def editar(id):
    conexao = conectar()
    cursor = conexao.cursor(dictionary=True)

    if request.method == "POST":
        nome = request.form["nome"]
        genero = request.form["genero"]
        plataforma = request.form["plataforma"]
        status = request.form["status"]
        nota = request.form["nota"]
        comentario = request.form["comentario"]

        sql = """
        UPDATE filmes
        SET nome=%s, genero=%s, plataforma=%s, status=%s, nota=%s, comentario=%s
        WHERE id=%s
        """

        valores = (nome, genero, plataforma, status, nota, comentario, id)

        cursor.execute(sql, valores)
        conexao.commit()

        cursor.close()
        conexao.close()

        return redirect(url_for("index"))

    cursor.execute("SELECT * FROM filmes WHERE id=%s", (id,))
    filme = cursor.fetchone()

    cursor.close()
    conexao.close()

    return render_template("editar.html", filme=filme)

@app.route("/deletar/<int:id>")
def deletar(id):
    conexao = conectar()
    cursor = conexao.cursor()

    cursor.execute("DELETE FROM filmes WHERE id=%s", (id,))
    conexao.commit()

    cursor.close()
    conexao.close()

    return redirect(url_for("index"))

if __name__ == "__main__":
    app.run(debug=True)