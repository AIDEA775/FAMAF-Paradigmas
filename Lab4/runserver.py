from flask import render_template, abort
from peewee import *
from playhouse.flask_utils import get_object_or_404
from app import app, flask_db, database
from models import User, Feed
from flask.ext.login import current_user
from auth import *
import feedparser

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

@app.route("/new_feed", methods=['POST', 'GET'])
@login_required
def new_feed():
    if request.method == 'POST':
        # hacer cosas con los feeds
        feedurl = request.form['feed_url']
        f = feedparser.parse(feedurl)
        fd = Feed.create(
            user = current_user.id,
            title = f.feed.title,
            url = f.feed.link,
            description = f.feed.description)
        return redirect(url_for('index'))
    else:
        return render_template("newfeed.html")
@app.route("/delete_feed/<feed>")
@login_required
def delete_feed(feed):
    try:
        fd = Feed.get(Feed.id == feed, Feed.user == True)
    except Feed.DoesNotExist:
        fd = None
        return "feed no valido"

    fd.delete_instance()
    return redirect(url_for('index'))

@app.route("/rss/<feed>")
@login_required
def rss(feed):

    pass

if __name__=="__main__":
    database.create_tables([User, Feed], safe=True)
    app.run()
