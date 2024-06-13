from flask import Blueprint, render_template, redirect, url_for, flash, request, current_app, current_user
from flask_login import login_required
from models import db, Book, Genre, Cover, Review
from tools import CoverSaver
from werkzeug.utils import secure_filename
import bleach
from markdown2 import markdown 
import os
from bleach import clean

book_form_bp = Blueprint('book_form', __name__, url_prefix='/book_form')

@book_form_bp.route('/book_create', methods=['GET', 'POST'])
@login_required
def book_create():
    genres = Genre.query.all()
    book = Book()
    if request.method == 'POST':
        title = request.form.get('title')
        author = request.form.get('author')
        description = bleach.clean(markdown(request.form.get('description')))
        publisher = request.form.get('publisher')
        year = request.form.get('year')
        pages = request.form.get('pages')
        genre_ids = request.form.getlist('genres')

        cover_id = None
        if 'cover' in request.files:
            cover_file = request.files['cover']
            if cover_file:
                cover_saver = CoverSaver(cover_file)
                cover = cover_saver.save()
                cover_id = cover.id

        try:
            book = Book(
                title=title,
                author=author,
                description=description,
                publisher=publisher,
                year=year,
                pages=pages,
                cover_id=cover_id
            )
            
            book.genres = Genre.query.filter(Genre.id.in_(genre_ids)).all()  # Связываем жанры с книгой
            
            db.session.add(book)
            db.session.commit()

            flash(f'Книга {book.title} была успешно добавлена!', 'success')
            return redirect(url_for('index'))
        except Exception as e:
            db.session.rollback()
            flash(f'При сохранении данных возникла ошибка: {str(e)}', 'danger')
            return render_template('books/add_book.html', genres=genres,book=book, form_data=request.form)

    return render_template('books/add_book.html', genres=genres, book=book)

@book_form_bp.route('/book/<int:book_id>/edit', methods=['GET', 'POST'])
@login_required
def edit_book(book_id):
    book = db.session.query(Book).filter_by(id=book_id).first()
    genres = Genre.query.all()
    if request.method == 'POST':
        book.title = request.form.get('title')
        book.author = request.form.get('author')
        book.description = bleach.clean(markdown(request.form.get('description')))
        book.publisher = request.form.get('publisher')
        book.year = request.form.get('year')
        book.pages = request.form.get('pages')
        genre_ids = request.form.getlist('genres')

        cover_id = None
        if 'cover' in request.files:
            cover_file = request.files['cover']
            if cover_file:
                cover_saver = CoverSaver(cover_file)
                cover = cover_saver.save()
                cover_id = cover.id
                book.cover_id = cover_id

        try:
            book.genres = Genre.query.filter(Genre.id.in_(genre_ids)).all()  # Связываем жанры с книгой
            
            db.session.commit()

            flash(f'Книга {book.title} была успешно обновлена!', 'success')
            return redirect(url_for('index'))
        except Exception as e:
            db.session.rollback()
            flash(f'При обновлении данных возникла ошибка: {str(e)}', 'danger')
            return render_template('books/edit_book.html', genres=genres, book=book)

    return render_template('books/edit_book.html', genres=genres, book=book)


@book_form_bp.route('/book/<int:book_id>/delete', methods=['GET', 'POST'])
@login_required
def delete_book(book_id):
    book = db.session.query(Book).filter_by(id=book_id).first()
    if not book:
        flash("Книга не найдена", "danger")
        return redirect(url_for('index'))

    if request.method == 'POST':
        try:
            # Удаляем файл обложки из файловой системы
            if book.cover and book.cover.filename:
                cover_path = os.path.join(current_app.config['UPLOAD_FOLDER'], book.cover.filename)
                if os.path.exists(cover_path):
                    os.remove(cover_path)
                    
            db.session.delete(book)
            db.session.commit()
            flash(f'Книга "{book.title}" была успешно удалена!', 'success')
        except Exception as e:
            db.session.rollback()
            flash(f'При удалении книги возникла ошибка: {str(e)}', 'danger')

        return redirect(url_for('index'))

    return render_template('books/delete_book.html', book=book)

@book_form_bp.route('/book/<int:book_id>/create_review', methods=['GET', 'POST'])
@login_required
def create_review(book_id):
    book = Book.query.get(book_id)
    if not book:
        flash("Книга не найдена", "danger")
        return redirect(url_for('index'))

    # Проверяем, была ли уже создана рецензия пользователем для данной книги
    existing_review = Review.query.filter_by(book_id=book_id, user_id=current_user.id).first()
    if existing_review:
        flash("Вы уже оставили рецензию для этой книги", "warning")
        return redirect(url_for('book_form.view_book', book_id=book_id))

    if request.method == 'POST':
        try:
            rating = int(request.form['rating'])
            text = request.form['text']

            # Санитизация текста рецензии с помощью bleach
            sanitized_text = clean(text, tags=[], attributes={}, styles=[], protocols=[])

            review = Review(book_id=book_id, user_id=current_user.id, rating=rating, text=sanitized_text)
            db.session.add(review)
            db.session.commit()

            flash("Рецензия успешно добавлена", "success")
            return redirect(url_for('book_form.view_book', book_id=book_id))
        except Exception as e:
            db.session.rollback()
            flash(f"Ошибка при добавлении рецензии: {str(e)}", "danger")

    return render_template('books/create_review.html', book=book)

# @book_form_bp.route('/book/<int:book_id>/view')
# def view_book(book_id):
#     book = Book.query.get_or_404(book_id)
#     reviews = Review.query.filter_by(book_id=book_id).all()
#     book_description_html = markdown.markdown(book.description)
#     return render_template('view_book.html', book=book, reviews=reviews, book_description_html=book_description_html)