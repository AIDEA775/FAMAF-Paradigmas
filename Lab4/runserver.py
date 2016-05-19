from flask import render_template, abort
from peewee import *
from playhouse.flask_utils import get_object_or_404
from app import app, flask_db, database
from models import User, Feed
from flask.ext.login import current_user
from auth import *

@app.route("/login/<provider>")
def login(provider):
    if (provider == "github"):
        return login_github()
    elif (provider == "google"):
        return login_google()

@app.route("/")
def start():
    if not current_user.is_anonymous:
        return redirect(url_for('index'))
    else:
        return render_template("login.html")

@app.route("/index")
@login_required
def index():
    return render_template("index.html")

@app.route("/new_feed")
@login_required
def new_feed():
    return "aca crear un nuevo feed ameo"

if __name__=="__main__":
    database.create_tables([User, Feed], safe=True)
    app.run()
