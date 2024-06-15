import os
from flask import url_for
from datetime import datetime
from werkzeug.security import check_password_hash, generate_password_hash
from flask_login import UserMixin
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship
from sqlalchemy import String, ForeignKey, DateTime, Text, Integer, MetaData, Column, Table

class Base(DeclarativeBase):
    metadata = MetaData(naming_convention={
        "ix": 'ix_%(column_0_label)s',
        "uq": "uq_%(table_name)s_%(column_0_name)s",
        "ck": "ck_%(table_name)s_%(constraint_name)s",
        "fk": "fk_%(table_name)s_%(column_0_name)s_%(referred_table_name)s",
        "pk": "pk_%(table_name)s"
    })

db = SQLAlchemy(model_class=Base)


class Role(Base):
    __tablename__ = 'roles'

    id = mapped_column(Integer, primary_key=True)
    name: Mapped[str] = mapped_column(String(255))
    description: Mapped[str] = mapped_column(Text)

    
class User(Base, UserMixin):
    __tablename__ = 'users'

    id: Mapped[int] = mapped_column(primary_key=True)
    login: Mapped[str] = mapped_column(String(100), unique=True)
    password_hash: Mapped[str] = mapped_column(String(200))
    last_name: Mapped[str] = mapped_column(String(100))
    first_name: Mapped[str] = mapped_column(String(100))
    middle_name: Mapped[str | None] = mapped_column(String(100))
    role_id: Mapped[int] = mapped_column(ForeignKey("roles.id"))


    role: Mapped["Role"] = relationship()

    def has_role(self, role_id):
        return self.role_id == role_id if self.role_id else False

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)
    
    @property
    def full_name(self):
        return ' '.join([self.last_name, self.first_name, self.middle_name or ''])

    def __repr__(self):
        return '<User %r>' % self.login
    

class Genre(db.Model):
    __tablename__ = 'genres'

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(255), unique=True)



class Cover(Base):
    __tablename__ = 'covers'

    id = Column(Integer, primary_key=True, autoincrement=True)
    filename = Column(String(255))
    mime_type = Column(String(255))
    md5_hash = Column(String(255))

    book = relationship('Book', back_populates='cover')

    def __repr__(self):
        return f'<Cover {self.filename}>'

    @property
    def storage_filename(self):
        _, ext = os.path.splitext(self.filename)
        return ext

    @property
    def url(self):
        return url_for('image', image_hash=self.md5_hash)

books_genres = Table('book_genre', Base.metadata,
    Column('book_id', Integer, ForeignKey('books.id', ondelete='CASCADE'), primary_key=True),
    Column('genre_id', Integer, ForeignKey('genres.id', ondelete='CASCADE'), primary_key=True)
)

class Book(Base):
    __tablename__ = 'books'

    id = Column(Integer, primary_key=True, autoincrement=True)
    title = Column(String(255), nullable=False)
    description = Column(Text, nullable=False)
    year = Column(Integer, nullable=False)
    publisher = Column(String(255), nullable=False)
    author = Column(String(255), nullable=False)
    pages = Column(Integer, nullable=False)
    cover_id = Column(Integer, ForeignKey('covers.id', ondelete='CASCADE'), nullable=True)
    cover = relationship('Cover', back_populates='book', cascade='all, delete-orphan', single_parent=True)
    genres = relationship('Genre', secondary=books_genres, back_populates='books')



Genre.books = relationship("Book", secondary=books_genres, back_populates="genres")

class Review(db.Model):
    __tablename__ = 'reviews'

    id = Column(Integer, primary_key=True, autoincrement=True)
    book_id = Column(Integer, ForeignKey('books.id', ondelete='CASCADE'), nullable=False)
    user_id = Column(Integer, ForeignKey('users.id', ondelete='CASCADE'), nullable=False)
    rating = Column(Integer, nullable=False)
    text = Column(Text, nullable=False)
    date_added = Column(DateTime, default=datetime.utcnow, nullable=False)

    book = relationship('Book', back_populates='reviews')
    user = relationship('User', back_populates='reviews')

    def __repr__(self):
        return f'<Review {self.id}>'

Book.reviews = relationship('Review', back_populates='book')
User.reviews = relationship('Review', back_populates='user')

class BookView(db.Model):
    __tablename__ = 'book_views'

    id = Column(Integer, primary_key=True, autoincrement=True)
    book_id = Column(Integer, ForeignKey('books.id', ondelete='CASCADE'), nullable=False)
    user_id = Column(Integer, ForeignKey('users.id', ondelete='CASCADE'))
    view_date = Column(DateTime, default=datetime.utcnow, nullable=False)

    book = relationship('Book', backref='views')
    user = relationship('User', backref='viewed_books')