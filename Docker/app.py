import os
import subprocess

from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/backup')
def backup():
    subprocess.call("/usr/bin/backup.sh")
    return {"status":"ok"}

if __name__ == "__main__":
    app.run(debug=True,host='0.0.0.0',port=int(os.environ.get('PORT', 8080)))
