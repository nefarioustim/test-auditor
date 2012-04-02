# -*- coding: utf-8 -*-

from flask import Flask

app = Flask(__name__)
app.config.from_pyfile('config.py')

#----------------------------------------
# Testing server
#----------------------------------------

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True, port=8000)
