from flask import Flask
from playhouse.flask_utils import FlaskDB
from flask.ext.login import LoginManager, UserMixin
import settings


app = Flask(__name__)
app.config.from_object(settings)

flask_db = FlaskDB(app)
database = flask_db.database
