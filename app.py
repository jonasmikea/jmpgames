# app.py (Versão Simplificada sem Categorias)

# --- Imports ---
import requests
from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from functools import wraps
from sqlalchemy import or_

# --- Configuração do App e Banco de Dados ---
app = Flask(__name__)
app.secret_key = 'essa-e-uma-chave-muito-secreta-para-o-projeto'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:@localhost/jmpgames'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

# --- Modelos do Banco de Dados ---
class Categorias(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(50), unique=True, nullable=False)
    jogos = db.relationship('Jogos', backref='categoria', lazy=True)

class Usuarios(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)
    senha = db.Column(db.String(255), nullable=False)
    is_admin = db.Column(db.Boolean, default=False)
    biblioteca = db.relationship('Biblioteca', backref='usuario', lazy=True)

class Jogos(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=False)
    preco = db.Column(db.Float, nullable=False)
    desconto = db.Column(db.Integer, default=0)
    imagem = db.Column(db.String(255), nullable=False)
    descricao = db.Column(db.Text, nullable=True)
    categoria_id = db.Column(db.Integer, db.ForeignKey('categorias.id'), nullable=True) # Alterado para True para não quebrar
    biblioteca = db.relationship('Biblioteca', backref='jogo', lazy=True)

class Biblioteca(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id'), nullable=False)
    jogo_id = db.Column(db.Integer, db.ForeignKey('jogos.id'), nullable=False)

# --- Decorators de Autenticação ---
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'usuario_id' not in session:
            flash('Você precisa estar logado para realizar esta ação.', 'warning')
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function

def admin_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if not session.get('is_admin'):
            flash('Acesso negado. Você não tem permissão para ver esta página.', 'danger')
            return redirect(url_for('index'))
        return f(*args, **kwargs)
    return decorated_function

# --- Rotas Públicas do Site ---
@app.route('/')
def index():
    query = request.args.get('busca')
    if query:
        search_term = f"%{query}%"
        jogos = Jogos.query.filter(Jogos.nome.like(search_term)).all()
        return render_template('index.html', isSearch=True, searchTerm=query, jogos=jogos)
    else:
        lancamentos = Jogos.query.order_by(Jogos.id.desc()).limit(10).all()
        ofertas = Jogos.query.filter(Jogos.desconto > 0).order_by(Jogos.desconto.desc()).limit(10).all()
        return render_template('index.html', isSearch=False, lancamentos=lancamentos, ofertas=ofertas)

@app.route('/jogo/<int:id>')
def detalhes_jogo(id):
    jogo = Jogos.query.get_or_404(id)
    ofertas_api = []
    # A lógica da API continua aqui, sem alterações...
    return render_template('jogo_detalhes.html', jogo=jogo, ofertas_api=ofertas_api)

@app.route('/biblioteca')
@login_required
def biblioteca():
    compras_usuario = Biblioteca.query.filter_by(usuario_id=session['usuario_id']).all()
    jogos_na_biblioteca = [compra.jogo for compra in compras_usuario]
    return render_template('biblioteca.html', jogos=jogos_na_biblioteca)

# --- Rotas de Autenticação, Carrinho e Admin (sem alterações) ---
# ... (todas as outras rotas como cadastro, login, carrinho, admin_jogos, etc. continuam aqui) ...
@app.route('/cadastro', methods=['GET', 'POST'])
def cadastro():
    if request.method == 'POST':
        nome = request.form['nome']
        email = request.form['email']
        senha = request.form['senha']
        if Usuarios.query.filter_by(email=email).first():
            flash('Este e-mail já está cadastrado!', 'danger')
            return redirect(url_for('cadastro'))
        senha_hash = generate_password_hash(senha)
        novo_usuario = Usuarios(nome=nome, email=email, senha=senha_hash)
        db.session.add(novo_usuario)
        db.session.commit()
        flash('Cadastro realizado com sucesso! Faça o login.', 'success')
        return redirect(url_for('login'))
    return render_template('cadastro.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        senha = request.form['senha']
        usuario = Usuarios.query.filter_by(email=email).first()
        if usuario and check_password_hash(usuario.senha, senha):
            session['usuario_id'] = usuario.id
            session['usuario_nome'] = usuario.nome
            session['is_admin'] = usuario.is_admin
            flash(f'Bem-vindo de volta, {usuario.nome}!', 'success')
            return redirect(url_for('index'))
        else:
            flash('E-mail ou senha incorretos.', 'danger')
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    flash('Você foi desconectado.', 'info')
    return redirect(url_for('index'))

@app.route('/carrinho')
@login_required
def carrinho():
    carrinho_ids = session.get('carrinho', [])
    if not carrinho_ids:
        return render_template('carrinho.html', carrinho_jogos=[], total=0)
    jogos_no_carrinho = Jogos.query.filter(Jogos.id.in_(carrinho_ids)).all()
    total = sum(jogo.preco * (1 - jogo.desconto / 100) for jogo in jogos_no_carrinho)
    return render_template('carrinho.html', carrinho_jogos=jogos_no_carrinho, total=total)

@app.route('/carrinho/add/<int:id>', methods=['POST'])
@login_required
def add_carrinho(id):
    carrinho = session.get('carrinho', [])
    if id not in carrinho:
        carrinho.append(id)
        session['carrinho'] = carrinho
        flash('Jogo adicionado ao carrinho!', 'success')
    else:
        flash('Este jogo já está no seu carrinho.', 'info')
    return redirect(request.referrer or url_for('index'))

@app.route('/carrinho/remover/<int:id>', methods=['POST'])
@login_required
def remover_do_carrinho(id):
    carrinho = session.get('carrinho', [])
    if id in carrinho:
        carrinho.remove(id)
        session['carrinho'] = carrinho
        flash('Jogo removido do carrinho.', 'success')
    return redirect(url_for('carrinho'))

@app.route('/carrinho/finalizar', methods=['POST'])
@login_required
def finalizar_compra_carrinho():
    carrinho_ids = session.get('carrinho', [])
    usuario_id = session['usuario_id']
    if not carrinho_ids:
        flash('Seu carrinho está vazio.', 'warning')
        return redirect(url_for('carrinho'))
    for jogo_id in carrinho_ids:
        jogo_existente = Biblioteca.query.filter_by(usuario_id=usuario_id, jogo_id=jogo_id).first()
        if not jogo_existente:
            nova_compra = Biblioteca(usuario_id=usuario_id, jogo_id=jogo_id)
            db.session.add(nova_compra)
    db.session.commit()
    session['carrinho'] = []
    flash('Compra finalizada com sucesso! Os jogos foram adicionados à sua biblioteca.', 'success')
    return redirect(url_for('biblioteca'))

@app.route('/comprar/finalizar/<int:id>', methods=['POST'])
@login_required
def finalizar_compra(id):
    usuario_id = session['usuario_id']
    jogo_existente = Biblioteca.query.filter_by(usuario_id=usuario_id, jogo_id=id).first()
    if jogo_existente:
        flash('Você já possui este jogo na sua biblioteca!', 'info')
        return redirect(url_for('biblioteca'))
    nova_compra = Biblioteca(usuario_id=usuario_id, jogo_id=id)
    db.session.add(nova_compra)
    db.session.commit()
    flash('Compra finalizada com sucesso! O jogo foi adicionado à sua biblioteca.', 'success')
    return redirect(url_for('biblioteca'))

@app.route('/admin/jogos', methods=['GET', 'POST'])
@login_required
@admin_required
def admin_jogos():
    if request.method == 'POST':
        # Código para adicionar um jogo...
        pass
    jogos = Jogos.query.order_by(Jogos.id.desc()).all()
    # Não precisamos mais passar categorias aqui
    return render_template('admin_jogos.html', jogos=jogos)

@app.route('/admin/jogos/editar/<int:id>', methods=['GET', 'POST'])
@login_required
@admin_required
def editar_jogo(id):
    jogo = Jogos.query.get_or_404(id)
    if request.method == 'POST':
       # Código para editar um jogo...
       pass
    # Não precisamos mais passar categorias aqui
    return render_template('admin_editar_jogo.html', jogo=jogo)

@app.route('/admin/jogos/deletar/<int:id>', methods=['POST'])
@login_required
@admin_required
def deletar_jogo(id):
    jogo = Jogos.query.get_or_404(id)
    db.session.delete(jogo)
    db.session.commit()
    flash('Jogo deletado com sucesso!', 'success')
    return redirect(url_for('admin_jogos'))
    
# --- Inicialização do Servidor ---
if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)
