from flask import request,jsonify
from src.controllers.userController import getUserAll
def userRoute (app):
    @app.route('/users', methods = ['GET'])
    def user():
        if request.method == 'GET':
            response = getUserAll()
            return jsonify(
                    response = response
                )