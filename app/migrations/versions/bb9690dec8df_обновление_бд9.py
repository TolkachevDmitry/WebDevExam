"""Обновление бд9

Revision ID: bb9690dec8df
Revises: 0c29f1725407
Create Date: 2024-06-15 13:31:54.542749

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'bb9690dec8df'
down_revision = '0c29f1725407'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('book_views', schema=None) as batch_op:
        batch_op.alter_column('user_id',
               existing_type=mysql.INTEGER(display_width=11),
               nullable=True)

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('book_views', schema=None) as batch_op:
        batch_op.alter_column('user_id',
               existing_type=mysql.INTEGER(display_width=11),
               nullable=False)

    # ### end Alembic commands ###
