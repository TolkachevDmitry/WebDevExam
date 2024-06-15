from flask import Flask, render_template, redirect, url_for, request, flash, send_file, session
from models import db, Book,Review,Cover,BookView,User
from flask_migrate import Migrate
from auth import bp as auth_bp, init_login_manager
from book_form import book_form_bp
from sqlalchemy import func
import os
from datetime import datetime, timedelta
from flask_login import current_user

app = Flask(__name__)
app.config.from_pyfile('config.py')

db.init_app(app)
init_login_manager(app)
db.login_view = 'auth.login'
db.login_message = 'Для выполнения данного действия необходимо пройти процедуру аутентификации'
db.login_message_category = 'warning'

migrate = Migrate(app, db)

app.register_blueprint(auth_bp)
app.register_blueprint(book_form_bp)

@app.route('/')
def index():
    current_date = datetime.utcnow()
    three_months_ago = current_date - timedelta(days=3 * 30)

    # Запрос для определения популярных книг, учитывающий все просмотры
    popular_books = db.session.query(Book, func.count(BookView.id).label('view_count')). \
        join(BookView, Book.id == BookView.book_id). \
        filter(BookView.view_date >= three_months_ago). \
        group_by(Book.id). \
        order_by(func.count(BookView.id).desc()).limit(5).all()

    page = request.args.get('page', 1, type=int)
    per_page = 10
    books_pog = db.session.query(Book).order_by(Book.year.desc()).paginate(page=page, per_page=per_page)

    book_stats = []
    for book in books_pog.items:
        average_rating = db.session.query(func.avg(Review.rating)).filter_by(book_id=book.id).scalar()
        review_count = db.session.query(func.count(Review.id)).filter_by(book_id=book.id).scalar()
        
        book_stats.append({
            'book': book,
            'average_rating': round(average_rating, 2) if average_rating else 'N/A',
            'review_count': review_count
        })

    # Получаем последние просмотренные книги для текущего пользователя или для анонимного пользователя
    recent_books = []
    if current_user.is_authenticated:
        recent_book_ids = db.session.query(BookView.book_id).filter_by(user_id=current_user.id). \
            order_by(BookView.view_date.desc()).limit(5).all()
        recent_books = [(db.session.query(Book).filter_by(id=book_id).first(), datetime.utcnow())
                        for (book_id,) in recent_book_ids]
    else:
        recent_book_ids = session.get('recent_book_ids', [])
        recent_books = [(db.session.query(Book).filter_by(id=book_id).first(), datetime.utcnow())
                        for book_id in recent_book_ids]

    return render_template('index.html', book_stats=book_stats, books_pog=books_pog, popular_books=popular_books, recent_books=recent_books)


@app.route('/images/<int:image_id>')
def images(image_id):
    cover = db.session.query(Cover).filter_by(id=image_id).first_or_404()
    file_extension = cover.filename.split('.')[-1]  # Получаем расширение файла
    file_path = os.path.join(app.config['UPLOAD_FOLDER'], cover.md5_hash + '.' + file_extension)
    return send_file(file_path, mimetype=cover.mime_type)

