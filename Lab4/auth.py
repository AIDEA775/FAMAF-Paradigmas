from flask import Flask, redirect, url_for, session, request, jsonify
from flask_oauthlib.client import OAuth
from app import app
from models import User, Feed

oauth = OAuth(app)

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

@app.route('/logout')
def logout():
    session.pop('github_token', None)
    return redirect(url_for('index'))

def login_github():
    return github.authorize(callback=url_for('authorized', _external=True))

def login_google():
    return "Hola ! aca va el coso de google"


@app.route('/login/authorized')
def authorized():
    resp = github.authorized_response()
    if resp is None:
        return None
    session['github_token'] = (resp['access_token'], '')
    datos = github.get('user')
    user = User.create(social_id=datos.data['id'], nickname=datos.data['name'], email=datos.data['email'])
    return user


@github.tokengetter
def get_github_oauth_token():
    return session.get('github_token')
