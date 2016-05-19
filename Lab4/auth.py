from flask import Flask, redirect, url_for, session, request
from flask_oauthlib.client import OAuth
from flask.ext.login import LoginManager, UserMixin, login_required, logout_user, login_user
from app import app
from models import User, Feed

oauth = OAuth(app)
login_manager = LoginManager()
login_manager.init_app(app)

github = oauth.remote_app(
    'github',
    consumer_key='4c2a197a8b494722d7be',
    consumer_secret='1a1b15613e7fb6f4ccc3f5f61e27e26c2a3fd3aa',
    request_token_params={'scope': 'user:email'},
    base_url='https://api.github.com/',
    request_token_url=None,
    access_token_method='POST',
    access_token_url='https://github.com/login/oauth/access_token',
    authorize_url='https://github.com/login/oauth/authorize'
)

def login_github():
    return github.authorize(callback=url_for('authorized', _external=True))

def login_google():
    return "Hola ! aca va el coso de google"

@app.route('/login/authorized')
def authorized():
    resp = github.authorized_response()
    if resp is None:
        flask.flash("authorized: resp es igual a None")
        return redirect(url_for('start'))
    session['github_token'] = (resp['access_token'], '')
    dat = github.get('user')
    user, new = User.get_or_create(
        social_id=dat.data['id'],
        nickname=dat.data['name'],
        email=dat.data['email'])
    login_user(user)
    return redirect(url_for('index'))

@github.tokengetter
def get_github_oauth_token():
    return session.get('github_token')

@login_manager.user_loader
def load_user(uid):
    return User.get(User.id == uid)

@app.route("/logout")
@login_required
def logout():
    logout_user()
    session.pop('github_token', None)
    return redirect(url_for('start'))
