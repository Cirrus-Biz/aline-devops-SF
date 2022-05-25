import os
import requests
import sys
import unittest
from faker import Faker
from dotenv import load_dotenv, find_dotenv

dir_path = os.path.dirname(os.path.realpath(__file__)) + "/"
sys.path.append(dir_path)

fake = Faker()

# loads bearer token from .env
load_dotenv(find_dotenv())
BEARER_TOKEN = os.environ.get("BEARER_TOKEN")
HOST = os.environ.get("HOST")
USERS_SERVICE_PORT = os.environ.get("USERS_SERVICE_PORT")
USERS_TEST_PORT = os.environ.get("USERS_TEST_PORT")

BASE = f"{HOST}"
headers = {"Authorization": f"Bearer {BEARER_TOKEN}"}

class Tests(unittest.TestCase):

# ~~~~~ Tests Functionality of Banks and Branches ~~~~~

    # checks banks and branches endpoint is healthy
    def test_check_connection_health(self):
        health_response = requests.get(BASE + f"{USERS_TEST_PORT}/health", headers=headers)
        statuscode = health_response.status_code
        self.assertEqual(statuscode, 200)

    def test_faker(self):
        zipcode = fake.zipcode()
        self.assertEqual(len(zipcode), 5)

    def test_banks(self):
        get_banks = requests.get(BASE + f"{USERS_SERVICE_PORT}/users", headers=headers)
        get_banks_status_code = get_banks.status_code
        self.assertEqual(get_banks_status_code, 200)


    def test_branches(self):
        get_branches = requests.get(BASE + f"{USERS_SERVICE_PORT}/members", headers=headers)
        get_branches_status_code = get_branches.status_code
        self.assertEqual(get_branches_status_code, 200)


