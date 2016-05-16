from flask import render_template, abort
from peewee import *
from playhouse.flask_utils import get_object_or_404
from app import app, flask_db, database
from models import User, Feed, Post, Tag

@app.route("/")
def hello():
    return "Hello World"

@app.route("/create/<title>")
def create(title):
    post = Post.create(title=title)
    return "<h1>{}</h1>".format(post.title)

@app.route("/create_tag/<tag>/<post_id>")
def create_tag(tag, post_id):
    post = Post.select().where(Post.id == post_id)
    if post.count() == 0:
        abort(404)
    post = post[0]
    tag = Tag.create(tag=tag, post=post.id)
    return "<h1>{} - {}</h1>".format(tag.tag, tag.post.title)

@app.route("/read/<id>")
def read(id):
    post = get_object_or_404(Post.select(), Post.id==id)
    tags = get_object_or_404(Tag.select(), Tag.post == post)
    return "<h1>{} -- {}</h1>".format(post.title, tags.tag)

@app.route("/hello/<name>")
def hello_template(name):
    return render_template("index.html", name=name)

if __name__=="__main__":
    database.create_tables([Post, Tag], safe=True)
    app.run()
