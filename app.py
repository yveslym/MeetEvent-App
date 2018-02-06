#!python

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


client = MongoClient('mongodb://localhost:27017/')
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
            users_collection = database.users_collection
            user = users_collection.find_one({'email': auth.username})
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
        user_find = users_collection.find_one({'email': auth.username})

        # Now that I have searched for them I have to see if they exist
        if user_find is not None:
            user_find.pop('password')
            print("The user has been succesfully fetched")
            return(user_find, 200, None)

    def post(self):
        # This function sends the user to the database 
        # pdb.set_trace()
        requested_json = request.json

        # We access headers headers through request.authorization and the body through request.json
        
       
        # Encodes password into a sanitized format
        encoded_password = requested_json['password'].encode("utf-8")

        # Based on the number of rounds we give it we run the encrpytion algorithm
        # against the encoded password
        hashed_password = bcrypt.hashpw(encoded_password, bcrypt.gensalt(rounds))

        user_find = users_collection.find_one({'email': requested_json['email']})

        # So updating value of old string password with new hashed password
        requested_json['password'] = hashed_password
        pdb.set_trace()

        # Make sure users give us email and password
        if user_find is not None:
            error_statement = "The users has already been posted"
            return error_statement, 400, None
        elif 'email' in requested_json and 'password' in requested_json:
            users_collection.insert_one(requested_json)
            requested_json.pop('password')
            print("User has succesfully been posted")
            return(requested_json, 201, None)

    @authenticated_request
    def delete(self):
        # This function is going to be the function that deletes users
        # First we have to make sure that the user exists before we can delete them
        auth = request.authorization
        # pdb.set_trace()

        user_find = users_collection.find_one({'email': auth.username})

        if user_find is not None:
            users_collection.remove(user_find)
            user_find.pop('password')
            return user_find, 204, None

            

class Categories(Resource):

    @authenticated_request
    def post(self):
        '''This function is what is responsible for posting users categories to the database'''
        # First we have to make sure the user is logged in before they can post categories
        auth = request.authorization

        user_find = users_collection.find_one({'email': auth.username})
        requested_json = request.json
        category_collection = database.category_collection

        if 'email' in requested_json and 'categories' in requested_json and user_find is not None:
            category_collection.insert_one(requested_json)
            return requested_json, 201, None

    @authenticated_request
    def patch(self):
        '''This is the function that is going to delete the users interested_categories'''
        # First we have to make sure that the user is logged in
        auth = request.authorization

        user_find = users_collection.find_one({'email': auth.username})
        category_collection = database.category_collection
        category_find = category_collection.find_one({'email': auth.username})
        requested_json = request.json
        
        if user_find is not None and category_find is not None and 'email' in requested_json and 'categories' in requested_json:
            category_find['categories'] = requested_json['categories']
            category_collection.save(category_find)
            return category_find, 204, None

    @authenticated_request
    def get(self):
        '''This is the function that is going to fetch users categories'''
        # First we have to make sure that the user is logged in
        auth = request.authorization
        # pdb.set_trace()
        user_find = users_collection.find_one({'email': auth.username})
        category_collection = database.category_collection
        category_find = category_collection.find_one({'email': auth.username})

        if user_find is not None:
            if category_find is not None:
                print('The user categories has been successfully fetched')
                return category_find, 200, None
            elif category_find is None:
                print("No categories")
                return None, 200,None


class UserFavoriteEvents(Resource):
    @authenticated_request
    def post(self):
        '''This is going to be the function that sends  the users liked events to the database'''
        auth = request.authorization
        requested_json = request.json
        user_find = users_collection.find_one({'email': auth.username})
        event_collection = database.event_collection

        if user_find is not None and 'email' in requested_json and 'id' in requested_json:
            event_collection.insert_one(requested_json)
            print('The users favorited events has been posted to the database')
            return requested_json, 201, None

    @authenticated_request
    def get(self):
        ''' This is the function that fetches the users favorited events'''
        auth = request.authorization

        user_find = users_collection.find_one({'email': auth.username})

        event_collection = database.event_collection

        event_find = event_collection.find_one({'email': auth.username})

        if user_find is not None:
            if event_find is not None:
                success_statement = ('The users favorited events have not been returned ')
                return event_find,200, None, success_statement
            elif event_find is None:
                no_event_found = ('The user is existent but does not have any favorited events')
                return (no_event_found, 200, None)
   
    @authenticated_request
    def delete(self):
        ''' This is the function that deletes a user favorited events or dislikes them'''
        auth = request.authorization

        requested_json = request.json

        user_find = users_collection.find_one({'email': auth.username})

        event_collection = database.event_collection
        pdb.set_trace()
        event_find = event_collection.find_one({'email': auth.username, 'id': requested_json['id']})
        

        if 'id' in requested_json and 'email' in requested_json and event_find is not None:
            event_collection.remove(event_find)
            return event_find, 204, None

   
        

            

    
api.add_resource(User, "/users")
api.add_resource(UserFavoriteEvents, "/favorited_events")
api.add_resource(Categories, "/categories")

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