from flask import Flask, request, make_response
from flask_restful import Resource, Api
from pymongo import MongoClient
from bson.objectid import ObjectId
import bcrypt
import json
from CustomClass import JSONEncoder
from flask import jsonify
import pdb
from bson import BSON
from bson import json_util
from basicauth import decode
from bson.json_util import dumps

app = Flask(__name__)


client = MongoClient('mongodb://matthewHarrilal:matthewharrilal1@ds119088.mlab.com:19088/meet_event_development')
app.db = client.meet_event_development
database = app.db
rounds = app.bcrypt_rounds = 5
api = Api(app)
users_collection = database.users_collection

def authenticated_request(func):
    def wrapper(*args, **kwargs):
        auth = request.authorization
        print('***********')
        print(request.authorization)
        print('***********')
        auth_code = request.headers['authorization']
        email,password = decode(auth_code)

        if email is not None and password is not None:
            user_collection = database.orchard_collection
            user = user_collection.find_one({'email': email})
            if user is not None:
                encoded_password = password.encode('utf-8')
                if bcrypt.checkpw(encoded_password, user['password']):
                    return func(*args, **kwargs)
                else:
                    return ({'error': 'email or password is not correct'}, 401, None)
            else:
                return ({'error': 'could not find user in the database'}, 400, None)
        else:
            return ({'error': 'enter both email and password'}, 400, None)

    return wrapper


class User(Resource):

    # The decorator makes authenticated requests
    @authenticated_request
    def get(self):
        '''This is the log in function that is why we need the headers'''

        # Accessing the headers becuase that is where the users credentials are passed
        auth = request.authorization

        # So now that we have the credentials we have to see if the user exists
        user_find = user_collection.find_one({'email': auth.username})

        # Now that I have searched for them I have to see if they exist
        if user_find is not None:
            user_find.pop('password')
            print("The user has been succesfully fetched")
            return(user_find, 200, None)

    def post(self):
        # This function sends the user to the database 

        requested_json = request.json

        # We access headers headers through request.authorization and the body through request.json
        requested_password = request.json['password']

        # Encodes password into a sanitized format
        encoded_password = requested_password.encode("utf-8")

        # Based on the number of rounds we give it we run the encrpytion algorithm
        # against the encoded password
        hashed_password = bcrypt.hashpw(encoded_password, bcrypt.gensalt(rounds))

        # So updating value of old string password with new hashed password
        requested_password = hashed_password

        # Make sure users give us email and password
        if 'email' in requested_json and 'password' in requested_json:
            users_collection.insert_one(requested_json)
            requested_json.pop('password')
            print("User has succesfully been posted")
            return(requested_json, 201, None)

    @authenticated_request
    def delete(self):
        # This function is going to be the function that deletes users
        # First we have to make sure that the user exists before we can delete them
        auth = request.authorization

        user_find = user_collection.find_one({'email': auth.username})

        if user_find is not None:
            user_collection.remove(user_find)
            return user_find, 204, None

            

class Categories(Resource):

    @authenticated_request
    def post(self):
        '''This function is what is responsible for posting users categories to the database'''
        # First we have to make sure the user is logged in before they can post categories
        auth = request.authorization

        user_find = user_collection.find_one({'email': auth.username})
        requested_json = request.json
        category_collection = db.category_collection

        if 'email' in requested_json and 'categories' in requested_json and user_find is not None:
            user_find['email'] = requested_json['email']
            user_find["categories"] = requested_json['categories']
            return user_find, 201, None

    @authenticated_request
    def delete(self):
        '''This is the function that is going to delete the users interested_categories'''
        # First we have to make sure that the user is logged in
        auth = request.authorization

        user_find = users_collection.find_one({'email': auth.username})
        

        if user_find is not None and :

            


    
api.add_resource(User, "/users")

@api.representation('application/json')
def output_json(data, code, headers=None):
    resp = make_response(JSONEncoder().encode(data), code)
    resp.headers.extend(headers or {})
    return resp
# Encodes our resouces for



if __name__ == '__main__':
    # Turn this on in debug mode to get detailled information about request related exceptions: http://flask.pocoo.org/docs/0.10/config/
    app.config['TRAP_BAD_REQUEST_ERRORS'] = True
    app.run(debug=True)