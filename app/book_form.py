from flask import Blueprint, render_template, redirect, url_for, flash, request
from flask_login import login_required
from models import db, Book, Genre, Cover
from tools import CoverSaver
from werkzeug.utils import secure_filename
import hashlib
import os

book_form_bp = Blueprint('book_form', __name__, url_prefix='/book_form')

@book_form_bp.route('/book_create', methods=['GET', 'POST'])
@login_required
def book_create():
    if request.method == 'POST':
        title = request.form.get('title')
        author = request.form.get('author')
        description = request.form.get('description')
        publisher = request.form.get('publisher')
        year = request.form.get('year')
        pages = request.form.get('pages')
        genre_ids = request.form.getlist('genre')

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
            for genre_id in genre_ids:
                genre = Genre.query.get(genre_id)
                if genre:
                    book.genres.append(genre)

            db.session.add(book)
            db.session.commit()
            flash('Книга успешно сохранена', 'success')
            return redirect(url_for('index'))
        except Exception as e:
            db.session.rollback()
            flash(f'При сохранении данных возникла ошибка: {str(e)}', 'danger')
            genres = Genre.query.all()
            return render_template('add_book.html', action='Добавление', genres=genres, form_data=request.form)

    genres = Genre.query.all()
    return render_template('add_book.html', action='Добавление', genres=genres)

@book_form_bp.route('/book_edit/<int:book_id>', methods=['GET', 'POST'])
@login_required
def book_edit(book_id):
    book = Book.query.get_or_404(book_id)
    if request.method == 'POST':
        book.title = request.form.get('title')
        book.author = request.form.get('author')
        book.description = request.form.get('description')
        book.publisher = request.form.get('publisher')
        book.year = request.form.get('year')
        book.pages = request.form.get('pages')
        genre_ids = request.form.getlist('genre')

        book.genres.clear()
        for genre_id in genre_ids:
            genre = Genre.query.get(genre_id)
            if genre:
                book.genres.append(genre)

        try:
            db.session.commit()
            flash('Книга успешно обновлена', 'success')
            return redirect(url_for('index'))
        except Exception as e:
            db.session.rollback()
            flash(f'При обновлении данных возникла ошибка: {str(e)}', 'danger')
            genres = Genre.query.all()
            return render_template('book_form.html', action='Редактирование', genres=genres, book=book, form_data=request.form)

    genres = Genre.query.all()
    return render_template('book_form.html', action='Редактирование', genres=genres, book=book)

