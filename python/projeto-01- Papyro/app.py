from flask import Flask, render_template, request, redirect, url_for
import resources.database_connection as database_connection

app = Flask(__name__)
app.config['SECRET_KEY'] = 'Senai@791'


@app.route('/')
def inicio():
    return render_template('index.html')


@app.route('/cadastrar-livro', methods=['GET', 'POST'])
def cadastrar_livro():
    if request.method == 'POST':
        isbn = request.form['isbn']
        titulo = request.form['titulo']
        autor = request.form['autor']
        editora = request.form['editora']
        ano = request.form['ano']
        genero = request.form['genero']
        edicao = request.form['edicao']

        connection = database_connection.open_connection()
        cursor = connection.cursor()

        SQL = """
        INSERT INTO livros 
        (isbn, titulo, autor, editora, ano_publicacao, edicao, genero) 
        VALUES (%s, %s, %s, %s, %s, %s, %s);
        """
        values = (isbn, titulo, autor, editora, ano, edicao, genero)

        cursor.execute(SQL, values)
        connection.commit()

        cursor.close()
        connection.close()

        return redirect(url_for('listar_livro'))

    return render_template('cadastrar-livro.html')


@app.route('/listar-livro')
def listar_livro():
    connection = database_connection.open_connection()
    cursor = connection.cursor()

    SQL = "SELECT isbn, titulo, genero FROM livros WHERE ativo = 1;"
    cursor.execute(SQL)

    livros = cursor.fetchall()

    cursor.close()
    connection.close()

    return render_template('listar-livro.html', livros=livros)


@app.route('/excluir-livro/<isbn>')
def excluir_livro(isbn):
    connection = database_connection.open_connection()
    cursor = connection.cursor()

    SQL = "UPDATE livros SET ativo = 0 WHERE isbn = %s;"
    cursor.execute(SQL, (isbn,))
    connection.commit()

    cursor.close()
    connection.close()

    return redirect(url_for('listar_livro'))


@app.route('/editar-livro', methods=['POST'])
@app.route('/editar-livro/<isbn>', methods=['GET'])
def editar_livro(isbn=None):
    if request.method == 'POST':
        isbn = request.form['isbn']
        titulo = request.form['titulo']
        autor = request.form['autor']
        editora = request.form['editora']
        ano = request.form['ano']
        genero = request.form['genero']
        edicao = request.form['edicao']

        connection = database_connection.open_connection()
        cursor = connection.cursor()

        SQL = """
        UPDATE livros 
        SET titulo = %s, autor = %s, editora = %s, ano_publicacao = %s, genero = %s, edicao = %s 
        WHERE isbn = %s;
        """
        values = (titulo, autor, editora, ano, genero, edicao, isbn)

        cursor.execute(SQL, values)
        connection.commit()

        cursor.close()
        connection.close()

        return redirect(url_for('listar_livro'))

    connection = database_connection.open_connection()
    cursor = connection.cursor()

    SQL = """
    SELECT isbn, titulo, autor, editora, ano_publicacao, genero, edicao 
    FROM livros 
    WHERE isbn = %s;
    """
    cursor.execute(SQL, (isbn,))

    livro = cursor.fetchone()

    cursor.close()
    connection.close()

    return render_template('editar-livro.html', livro=livro)


@app.route('/cadastrar-leitor', methods=['GET', 'POST'])
def cadastrar_leitor():
    if request.method == 'POST':
        cpf = request.form['cpf']
        nome = request.form['nome']
        endereco = request.form.get('endereco')
        telefone = request.form['telefone']
        email = request.form['email']

        connection = database_connection.open_connection()
        cursor = connection.cursor()

        SQL = """
        INSERT INTO leitores 
        (cpf, nome, endereco, telefone, email) 
        VALUES (%s, %s, %s, %s, %s);
        """
        values = (cpf, nome, endereco, telefone, email)

        cursor.execute(SQL, values)
        connection.commit()

        cursor.close()
        connection.close()

        return redirect(url_for('listar_leitor'))

    return render_template('cadastrar-leitor.html')


@app.route('/listar-leitor')
def listar_leitor():
    connection = database_connection.open_connection()
    cursor = connection.cursor()

    SQL = "SELECT cpf, nome, email FROM leitores WHERE ativo = 1;"
    cursor.execute(SQL)

    leitores = cursor.fetchall()

    cursor.close()
    connection.close()

    return render_template('listar-leitor.html', leitores=leitores)


@app.route('/excluir-leitor/<cpf>')
def excluir_leitor(cpf):
    connection = database_connection.open_connection()
    cursor = connection.cursor()

    SQL = "UPDATE leitores SET ativo = 0 WHERE cpf = %s;"
    cursor.execute(SQL, (cpf,))
    connection.commit()

    cursor.close()
    connection.close()

    return redirect(url_for('listar_leitor'))


@app.route('/editar-leitor', methods=['POST'])
@app.route('/editar-leitor/<cpf>', methods=['GET'])
def editar_leitor(cpf=None):
    if request.method == 'POST':
        cpf = request.form['cpf']
        nome = request.form['nome']
        endereco = request.form['endereco']
        telefone = request.form['telefone']
        email = request.form['email']

        connection = database_connection.open_connection()
        cursor = connection.cursor()

        SQL = """
        UPDATE leitores 
        SET nome = %s, endereco = %s, telefone = %s, email = %s 
        WHERE cpf = %s;
        """
        values = (nome, endereco, telefone, email, cpf)

        cursor.execute(SQL, values)
        connection.commit()

        cursor.close()
        connection.close()

        return redirect(url_for('listar_leitor'))

    connection = database_connection.open_connection()
    cursor = connection.cursor()

    SQL = """
    SELECT cpf, nome, endereco, telefone, email 
    FROM leitores 
    WHERE cpf = %s;
    """
    cursor.execute(SQL, (cpf,))

    leitor = cursor.fetchone()

    cursor.close()
    connection.close()

    return render_template('editar-leitor.html', leitor=leitor)


@app.route('/realizar-emprestimo', methods=['GET', 'POST'])
def realizar_emprestimo():
    if request.method == 'POST':
        produto = request.form.get('isbn')
        tipo = request.form.get('tipo')
        quantidade = request.form.get('cpf')
        data = request.form.get('data-emprestimo')
        fornecedor = request.form.get('fornecedor')

        connection = database_connection.open_connection()
        cursor = connection.cursor()

        SQL = """
        INSERT INTO movimentacoes 
        (produto, tipo, quantidade, data, fornecedor)
        VALUES (%s, %s, %s, %s, %s);
        """
        values = (produto, tipo, quantidade, data, fornecedor)

        cursor.execute(SQL, values)
        connection.commit()

        cursor.close()
        connection.close()

        return redirect(url_for('listar_emprestimo'))

    return render_template('realizar-emprestimo.html')


@app.route('/listar-emprestimo')
def listar_emprestimo():
    connection = database_connection.open_connection()
    cursor = connection.cursor()

    SQL = "SELECT * FROM movimentacoes;"
    cursor.execute(SQL)

    emprestimos = cursor.fetchall()

    cursor.close()
    connection.close()

    return render_template('listar-emprestimo.html', emprestimos=emprestimos)


@app.route('/excluir-emprestimo/<id>')
def excluir_emprestimo(id):
    connection = database_connection.open_connection()
    cursor = connection.cursor()

    SQL = "UPDATE emprestimos SET ativo = 0 WHERE id = %s;"
    cursor.execute(SQL, (id,))
    connection.commit()

    cursor.close()
    connection.close()

    return redirect(url_for('listar_emprestimo'))


@app.route('/editar-emprestimo', methods=['POST'])
@app.route('/editar-emprestimo/<id>', methods=['GET'])
def editar_emprestimo(id=None):
    if request.method == 'POST':
        id = request.form['id']
        cpf = request.form['cpf']
        isbn = request.form['isbn']
        data_emprestimo = request.form['data-emprestimo']
        data_devolucao = request.form['data-devolucao']

        connection = database_connection.open_connection()
        cursor = connection.cursor()

        SQL = """
        UPDATE emprestimos 
        SET cpf_leitor = %s, isbn_livro = %s, data_emprestimo = %s, data_devolucao = %s 
        WHERE id = %s;
        """
        values = (cpf, isbn, data_emprestimo, data_devolucao, id)

        cursor.execute(SQL, values)
        connection.commit()

        cursor.close()
        connection.close()

        return redirect(url_for('listar_emprestimo'))

    connection = database_connection.open_connection()
    cursor = connection.cursor()

    SQL = """
    SELECT id, cpf_leitor, isbn_livro, data_emprestimo, data_devolucao 
    FROM emprestimos 
    WHERE id = %s;
    """
    cursor.execute(SQL, (id,))

    emprestimo = cursor.fetchone()

    cursor.close()
    connection.close()

    return render_template('editar-emprestimo.html', emprestimo=emprestimo)


if __name__ == '__main__':
    app.run(debug=True)