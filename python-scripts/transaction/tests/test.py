import os
import requests
import sys
import unittest
from dotenv import load_dotenv, find_dotenv

dir_path = os.path.dirname(os.path.realpath(__file__)) + "/"
sys.path.append(dir_path)

# loads bearer token from .env
load_dotenv(find_dotenv())
BEARER_TOKEN = os.environ.get("BEARER_TOKEN")
HOST = os.environ.get("HOST")
TRANSACTION_TEST_PORT = os.environ.get("TRANSACTION_TEST_PORT")

BASE = f"{HOST}"
headers = {"Authorization": f"Bearer {BEARER_TOKEN}"}

class Tests(unittest.TestCase):

# ~~~~~ Tests Functionality of Transaction ~~~~~

    # checks transactions endpoint is healthy
    def test_check_connection_health_transaction(self):
        health_response = requests.get(BASE + f"{TRANSACTION_TEST_PORT}/health", headers=headers)
        statuscode = health_response.status_code
        self.assertEqual(statuscode, 200)

    # checks members endpoint is healthy
    def test_check_connection_health_member(self):
        health_response = requests.get(BASE + f"{TRANSACTION_TEST_PORT}/health", headers=headers)
        statuscode = health_response.status_code
        self.assertEqual(statuscode, 200)

    # add more unit tests



