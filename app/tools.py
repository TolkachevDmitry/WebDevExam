import hashlib
import uuid
import os
from werkzeug.utils import secure_filename
from flask import current_app
from models import db, Cover

class CoverSaver:
    def __init__(self, file):
        self.file = file

    def save(self):
        self.img = self.__find_by_md5_hash()
        if self.img is not None:
            return self.img
        filename = secure_filename(self.file.filename)
        self.img = Cover(
            filename=filename,
            mime_type=self.file.mimetype,
            md5_hash=self.md5_hash)
        db.session.add(self.img)
        self.file.save(
            os.path.join(current_app.config['UPLOAD_FOLDER'],
                        str(self.img.id) + os.path.splitext(filename)[1]))
        return self.img


    def __find_by_md5_hash(self):
        self.md5_hash = hashlib.md5(self.file.read()).hexdigest()
        self.file.seek(0)
        return db.session.execute(db.select(Cover).filter(Cover.md5_hash == self.md5_hash)).scalar()

