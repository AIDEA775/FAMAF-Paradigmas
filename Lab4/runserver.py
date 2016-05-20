from flask import render_template, request
from peewee import *
from app import app, database
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
    if current_user.is_anonymous:
        return render_template("login.html")
    else:
        return redirect(url_for('index'))

@app.route("/index")
@login_required
def index():
    return render_template("index.html")

@app.route("/new_feed", methods=['POST', 'GET'])
@login_required
def new_feed():
    if request.method == 'POST':
        feedurl = request.form['feed_url']
        f = feedparser.parse(feedurl)
        if ('title' in f.feed and 'description' in f.feed):
            Feed.create(
                user = current_user.id,
                title = f.feed.title,
                url = feedurl,
                description = f.feed.description)
            return redirect(url_for('index'))
        return render_template("newfeed.html")
    else:
        return render_template("newfeed.html")

@app.route("/delete_feed/<feed>")
@login_required
def delete_feed(feed):
    try:
        fd = Feed.get(Feed.id == feed, Feed.user == current_user.id)
        fd.delete_instance()
        return redirect(url_for('index'))
    except Feed.DoesNotExist:
        return redirect(url_for('index'))

@app.route("/rss/<feed>")
@login_required
def rss(feed):
    try:
        fd = Feed.get(Feed.id == feed, Feed.user == current_user.id)
        return render_template("rss.html",
            feed=fd,
            entries=feedparser.parse(fd.url).entries)
    except Feed.DoesNotExist:
        return redirect(url_for('index'))

if __name__=="__main__":
    database.create_tables([User, Feed], safe=True)
    app.run()
