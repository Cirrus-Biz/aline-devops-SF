"""
    This script attempts to register user.
    It then logs in with that user to parse header response holding JWT token. 
    It then writes this token to .env file. 
    These tokens expire every 7 days.
    Currently You can run this if getting 403's to refresh token. 

    Set HOST variable to the host you are sending requests too
"""

import os
import requests
from datetime import datetime
from dotenv import load_dotenv, find_dotenv

dir_path = os.path.dirname(os.path.realpath(__file__))

load_dotenv(f"{dir_path}/.env_hosts")
HOST = os.environ.get("HOST")
USERS_SERVICE_PORT = os.environ.get("USERS_SERVICE_PORT")

BASE = f"{HOST}{USERS_SERVICE_PORT}"

def renew_bearer():
    try:

        payload =  {
                      "username": "stephenfreed",
                      "password": "Password01!",
                      "role": "admin",
                      "firstName": "stephen",
                      "lastName": "Freed",
                      "email": "stephen@gmail.com",
                      "phone": "123-123-1234"}
               

        # posts data to registration endpoint
        response = requests.post(BASE + "/users/registration", json=payload)
        response_code = response.status_code

        with open(f"{dir_path}/bearer_log.txt", "a") as my_file:
            todays_date = datetime.now().strftime("%d/%m/%Y %H:%M:%S")
            my_file.write(f"BEARER_TOKEN Registration on {todays_date} ~ Status:{response_code}\n")

    except Exception as e:
        print(e)

    finally:

        payload =  {
                      "username": "stephenfreed",
                      "password": "Password01!"}

        # posts data to login
        response = requests.post(BASE + "/login", json=payload)

        # parses bearer token from headers
        response_headers = response.headers
        bearer_token = response_headers["Authorization"][7:]

        # clears .env file and writes new bearer token to it
        with open(f"{dir_path}/.env", "w") as my_file:
            my_file.write(f"BEARER_TOKEN={bearer_token}\n")
            
        # reads lines from .env_hosts 
        with open(f"{dir_path}/.env_hosts", "r") as my_file:
            hosts_file_lines = my_file.read()

        # appends lines in .env_hosts to .env after bearer token
        with open(f"{dir_path}/.env", "a") as my_file:
            for line in hosts_file_lines:
                my_file.write(line)

        # writes info to log file
        with open(f"{dir_path}/bearer_log.txt", "a") as my_file:
            todays_date = datetime.now().strftime("%d/%m/%Y %H:%M:%S")
            my_file.write(f"BEARER_TOKEN renewed on {todays_date}\n")


renew_bearer()
