from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
class Form(FlaskForm):
     x = StringField('a',validators=[])
     y = StringField('b',validators=[])
     Submit = SubmitField('Submit')