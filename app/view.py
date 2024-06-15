from flask import session
from datetime import datetime
from models import db, BookView

def track_book_view(user_id, book_id):
    today = datetime.utcnow().date()
    start_of_day = datetime.combine(today, datetime.min.time())
    end_of_day = datetime.combine(today, datetime.max.time())

    if user_id is None:
        view_filter = BookView.book_id == book_id
    else:
        view_filter = (BookView.user_id == user_id) & (BookView.book_id == book_id)

    view_count_today = BookView.query.filter(
        view_filter,
        BookView.view_date >= start_of_day,
        BookView.view_date <= end_of_day
    ).count()

    if view_count_today >= 10:
        return False

    new_view = BookView(user_id=user_id, book_id=book_id)
    db.session.add(new_view)
    db.session.commit()

    # Добавляем book_id в сессию для неавторизованных пользователей
    if not user_id:
        recent_book_ids = session.get('recent_book_ids', [])
        if book_id not in recent_book_ids:
            recent_book_ids.insert(0, book_id)
            # Ограничиваем список до 5 последних просмотренных книг
            session['recent_book_ids'] = recent_book_ids[:5]

    return True
