### Test Functionality Of Gateway, Microservices, and MySQL Database
---

#### Each Directory Tests Different API Microservice Functionalities.

### Setup
- pip install -r requirements.txt
- change host variables in .env_hosts to the appropriate values 
- run bearer_renew_token.py to renew bearer token and set environment variables before running python applications
- bearer_renew_token.py will write the bearer token and host variables to .env that the applications pull from

##### Go To Each Directory and Run The Main Python File (named the same as directory)

- Applicants ~ Choose Number Of Applicants You Would Like To Create ~
- Applications ~  Create Applications And Choose Accounts In Application ~
- Banks-and-branches ~ Create Bank / Add Branches To Existing Banks ~
- Transaction ~ Choose From Valid Members And Transfer Between Accounts ~
- Users ~  Create Admin and Member Users From Valid Non-User Members ~

##### Follow the prompts and choices to confirm proper functionality.

![script-example](./script-example.png)


