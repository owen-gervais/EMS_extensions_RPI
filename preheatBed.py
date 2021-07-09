import requests
import os
import sys
import json

'''
preheatBed():

    Calls the Octoprint API from the EMS and
    is used to interface with custom Thingworx
    services

'''
def preheatBed(temperature:int) -> bool:

    # Safety check so that the temperature is
    # not overloaded 
    if temperature > 70:
        temperature = 0

    # URL Componnents
    base = "http://octopi.local"
    url = "/api/printer/bed"

    # Defining the headers 
    headers = {
        'X-Api-Key': os.getenv("OCTOPI_KEY"),
        'Content-Type': "application/json"
        }

    # Defining the payload
    payload = {
      "command": "target",
      "target": temperature
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

targetTemp = sys.argv[1]

preheatBed(targetTemp)
