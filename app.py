from flask import Flask
from src.routes.user import userRoute


app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World! My name is Bryan Arrivasplata Rojas, creador de esta RestApi\n WebSite: <a href="https://www.bryanarrivasplata.com">https://www.bryanarrivasplata.com</a> \n Linkedin: <a href="https://www.linkedin.com/in/bryan-daniell-arrivasplata-rojas-156508213/">bryan-daniell-arrivasplata-rojas</a> '

userRoute(app)



if __name__ == "__main__":
    app.run('0.0.0.0')