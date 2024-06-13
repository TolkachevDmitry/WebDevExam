from flask import Flask, render_template, redirect, url_for, request, flash
from models import db, Book
from flask_migrate import Migrate
from auth import bp as auth_bp, init_login_manager
from book_form import book_form_bp

app = Flask(__name__)
app.config.from_pyfile('config.py')

db.init_app(app)
init_login_manager(app)

migrate = Migrate(app, db)

app.register_blueprint(auth_bp)
app.register_blueprint(book_form_bp)

@app.route('/')
def index():
    book = db.session.execute(db.select(Book)).scalars()
    return render_template('index.html', books=book)
