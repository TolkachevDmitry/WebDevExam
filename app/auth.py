from flask import Blueprint, render_template, redirect, url_for, flash, request
from flask_login import LoginManager, login_user, logout_user, login_required
from models import db, User
from werkzeug.security import check_password_hash, generate_password_hash

bp = Blueprint('auth', __name__, url_prefix='/auth')

def init_login_manager(app):
    login_manager = LoginManager()
    login_manager.login_view = 'auth.login'
    login_manager.login_message = 'Для доступа к данной странице необходимо пройти процедуру аутентификации.'
    login_manager.login_message_category = 'warning'
    login_manager.user_loader(load_user)
    login_manager.init_app(app)

def load_user(user_id):
    user = db.session.execute(db.select(User).filter_by(id=user_id)).scalar()
    return user

@bp.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        login_input = request.form.get('login')
        password = request.form.get('password')

        if login_input and password:
            user = db.session.query(User).filter_by(login=login_input).first()

            if user:
                print(f"Введенный пароль: {generate_password_hash(password)}")
                print(f"Хеш пароля из базы данных: {user.password_hash}")

                if check_password_hash(user.password_hash, password):
                    login_user(user)
                    flash('Вы успешно аутентифицированы.', 'success')
                    next_url = request.args.get('next')
                    return redirect(next_url or url_for('index'))

        flash('Невозможно аутентифицироваться с указанными логином и паролем.', 'danger')

    return render_template('auth/login.html')

@bp.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('index'))
