from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

app = Flask(__name__)

# Configuração da conexão com o banco de dados MySQL via pymysql
# Altere 'root' e 'sua_senha' conforme as suas credenciais locais do MySQL Workbench
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:dev%402025@localhost/controle_financas'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

# Definição do Modelo correspondente à tabela 'transacao'
class Transacao(db.Model):
    __tablename__ = 'transacao'
    
    id = db.Column(db.Integer,primary_key=True, autoincrement=True)
    descricao = db.Column(db.String(100), nullable=False)
    valor = db.Column(db.Numeric(10, 2), nullable=False)
    tipo = db.Column(db.String(10), nullable=False)
    data = db.Column(db.Date, nullable=False)

# Rota Principal: Listar transações e calcular saldo atual
@app.route('/')
def index():
    # Busca todas as transações ordenadas por data
    transacoes = Transacao.query.order_by(Transacao.data.desc()).all()
    
    # Cálculo dinâmico do saldo no backend
    total_entradas = sum(t.valor for t in transacoes if t.tipo == 'entrada')
    total_saidas = sum(t.valor for t in transacoes if t.tipo == 'saida')
    saldo_atual = total_entradas - total_saidas
    
    return render_template('index.html', transacoes=transacoes, saldo_atual=saldo_atual)

# Rota: Criar Nova Transação
@app.route('/add', methods=['POST'])
def add_transacao():
    descricao = request.form.get('descricao')
    valor = float(request.form.get('valor'))
    tipo = request.form.get('tipo')
    # Conversão de string HTML (YYYY-MM-DD) para objeto Date do Python
    data_str = request.form.get('data')
    data = datetime.strptime(data_str, '%Y-%m-%d').date()

    nova_transacao = Transacao(descricao=descricao, valor=valor, tipo=tipo, data=data)
    db.session.add(nova_transacao)
    db.session.commit()
    
    return redirect(url_for('index'))

# Rota: Formulário de Edição e Processamento da Atualização
@app.route('/editar/<int:id>', methods=['GET', 'POST'])
def editar_transacao(id):
    transacao = Transacao.query.get_or_404(id)
    
    if request.method == 'POST':
        transacao.descricao = request.form.get('descricao')
        transacao.valor = float(request.form.get('valor'))
        transacao.tipo = request.form.get('tipo')
        data_str = request.form.get('data')
        transacao.data = datetime.strptime(data_str, '%Y-%m-%d').date()
        
        db.session.commit()
        return redirect(url_for('index'))
        
    return render_template('editar.html', transacao=transacao)

# Rota: Excluir Transação
@app.route('/deletar/<int:id>')
def deletar_transacao(id):
    transacao = Transacao.query.get_or_404(id)
    db.session.delete(transacao)
    db.session.commit()
    return redirect(url_for('index'))

if __name__ == '__main__':
    # Cria as tabelas caso não existam e inicia o servidor em modo de desenvolvimento
    with app.app_context():
        db.create_all()
    app.run(debug=True)