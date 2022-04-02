# 引入模組
# Import Module
# import boto3
from flask import Flask, jsonify, request,render_template,Blueprint,session
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Column, Integer, String, Float
from flask_jwt_extended import JWTManager, jwt_required,create_access_token
from flask_marshmallow import Marshmallow
from flask_s3 import FlaskS3
import os
import json
#from models import User
# Configuration 設定
app = Flask(__name__,template_folder='app/templates',static_folder="app/static")
app.secret_key = ""
basedir = os.path.abspath(os.path.dirname(__file__))
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'mockdatabase.db')
app.config['JWT_SECRET_KEY'] = ''
#client = boto3.client('rds')

bp =Blueprint('app',__name__)
#app.config['']

db = SQLAlchemy()
ma = Marshmallow(app)
jwt = JWTManager(app)
#@app.cli.command('db_create')
#def db_create():

# 頁面導向

@app.route('/') #指明路徑
def hello_world():
    return 'Hello World!'

@app.route('/index')  #指明路徑
def index():
    return render_template('page/index.html')


@app.route('/search') #指明路徑
def search():
    return render_template('search.html')


@app.route('/aboutus') #指明路徑
def aboutus():
    return render_template('page/aboutus.html')

@app.route('/super_simple')  #指明路徑
def super_simple():
    return jsonify(message='Hello from the Planetary API.'),200 #當伺服器的狀態碼為200就回傳此項

@app.route('/not_found') #你的路徑url之後增添的東西
def not_found():
    return jsonify(message='That resource was not found'), 404 #當伺服器的狀態碼為404就回傳此項

@app.route('/parameters')
def parameters():
    name = request.args.get('name')
    age = int(request.args.get('age'))
    if age < 18:
        return jsonify(message='Sorry '+ name + ', you are not old enough.'),401
    else:
        return jsonify(message='Welcome'+ name +',you are old enough!'), 200


@app.route('/redirectrestaurant') #指明路徑
def redirectrestaurant():
    return render_template('addrestaurantmethod.html')

@app.route('/table') #指明路徑
def table():
    return render_template('page/table.html')
#@bp.route('/',methods=['POST'])
#def register():

# 錯誤處理
@app.errorhandler(404) #指明錯誤
def page_not_found(e):
    return render_template('./error/error.html', ErrorStatus=404), 404

@app.errorhandler(500) #指明錯誤
def infernal_server_error(e):
    return render_template('./error/error.html', ErrorStatus=500), 500


# 更新

# 刪除
# Database Model
#class User(db.Model):
#    __tablename__ = ''

@app.route('/api')
def session_api():
    return jsonify(list(session.keys()))

@app.route('/page/restaurant/<int:id>/<string:restaurant>') #指明路徑
def restaurant(id:int,restaurant:str):
    return render_template('page/restaurant.html', id=id,restaurant=restaurant)

@app.route('/page/viewrestaurant') #指明路徑
def viewrestaurant():
    return render_template('viewrestaurant.html')
#數據庫
#class Name(db.Model):
# __tablename__ = 'posts'
# id = db.Column(db.Text,primary_key=True)


if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0',port=5000) #該app會此界面的0.0.0.0的5000埠上運行所以你要額外在securitygroup上

# 表單
#class EditProfileForm(FlaskForm):
# name = StringField('Real name',validators=[Length(0,64)])
# location = StringField('Location',validators=[Length(0,64)])
# about_me = TextAreaField('About me')
# submit = SubmitField('Submit')

# ssl_context='adhoc'

#可能的方案
#@bp.route('/formregister',methods = ['post'])
#def registerform():
#   if request.method == 'POST':
#        mockdb1 = {}
#        if os.path.exists('collectioninspiredbymodule13/folder1/mockdb.json'):
#             with open('mockdb1.json') as mockdb1file:
#                mockdb1 = json.load(mockdb1)
#        if request.form['name'] in mockdb1.keys():

#@bp.route('/formregister',methods=['GET','POST'])
#def register():
#  form = RegistrationForm()
#  if form.validate_on_submit():
#  User = User(email=form.email.data,username=form.username.data)
#  request.form['name']
#  Email = request.form['email']
#  Password = request.form['password']
#  db.session.add()

#@app.route('/register', methods=['POST'])
#def register():
#    email = request.form['email']

#    test = User.query.filter_by(email=email).first()
#    if test:
#        return jsonify(message='That email already exists.'), 409
#    else:
#        first_name = request.form['first_name']
#        last_name = request.form['last_name']
#        email = request.form['']
#        password = request.form['password']
#        user = User(first_name=first_name, last_name=last_name, email=email, password=password)
#        db.session.add(user)
#        db.session.commit()
#      return jsonify(message="User created successfully."), 201
#  with open('.json','w/r/x') as :
#  json.dump()

# 例子
@app.route('/url_variables/<string:name>/<int:age>')
def url_variables(name:str,age:int):
    if age < 18:
        return jsonify(message='Sorry '+ name + ', you are not old enough.'),401
    else:
        return jsonify(message='Welcome'+ name +',you are old enough!'), 200