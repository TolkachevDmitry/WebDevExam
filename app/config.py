import os

SECRET_KEY = 'b3baa1cb519a5651c472d1afa1b3f4e04f1adf6909dae88a4cd39adc0ddd9732'

SQLALCHEMY_DATABASE_URI = 'mysql+mysqlconnector://std_2425_exam:qwerty123@std-mysql.ist.mospolytech.ru/std_2425_exam'
SQLALCHEMY_TRACK_MODIFICATIONS = False
SQLALCHEMY_ECHO = True

UPLOAD_FOLDER = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'media', 'images')
