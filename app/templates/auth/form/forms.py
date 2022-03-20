from flask_wtf import FlaskForm
from wtforms.validators import DataRequired,Length,Email,Regexp,EqualTo
from wtforms import ValidationError
from wtforms import StringField,PasswordField,BooleanField,SubmitField
#按Flask的框架預設那些Input欄位
#class EditProfileForm(FlaskForm):
#    name = StringField('Real Name',validator)

class RegistrationForm(FlaskForm):
    email = StringField('Email',validators=[DataRequired(),Length(1,64),Email()])
    username = StringField('Username',validators=[DataRequired(),Length(1,64)],Regexp('^[A-Za-z][A-Za-z0-9_.]'))
