import requests
import asyncio
import json
import sys
import os

dist = sys.argv[1]
axis = sys.argv[2]


apiKey = 'B8BE447F514B426FB629108B47EC01FE'

base = 'http://octopi.local'
url = '/api/printer/printhead'

headers = {
    'X-Api-Key': apiKey,
    'Content-Type': 'application/json',
    'accept': 'application/json'
    }

payload = {"command": "jog",
            str(axis): float(dist)
           }

params = {}

response = requests.request("POST", base+url, params=params, headers=headers, data=json.dumps(payload))

