import requests
import os
import sys
import json

'''
cancelPrint():

    Calls the Octoprint API from the EMS and
    is used to interface with custom Thingworx
    services

'''
def cancelPrint() -> bool:

    # URL Componnents
    base = "http://octopi.local"
    url = "/api/job"

    # Defining the headers 
    headers = {
        'X-Api-Key': os.getenv("OCTOPI_KEY"),
        'Content-Type': "application/json"
        }

    # Defining the payload
    payload = {
      "command": "cancel"
    }

    # Defining request parameters
    params = {}

    # Calling the tool temp endpoint
    try:
        response = requests.request("POST",
                                    base+url,
                                    params=params,
                                    headers=headers,
                                    data=json.dumps(payload))
        return True
    
    except:
        return False
    
#-----------------------------------------------------------------
cancelPrint()

