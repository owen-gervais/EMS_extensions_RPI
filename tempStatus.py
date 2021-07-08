import requests
import os

base = "http://octopi.local"
url = "/api/printer"
query ="?apikey="
apikey = os.getenv("OCTOPI_KEY")

reqString = base+url+query+apikey 

try:
    r = requests.get(reqString)
    prntrStatus = r.json()
    bedTemp = prntrStatus['temperature']['bed']['actual']
    extrTemp = prntrStatus['temperature']['tool0']['actual']
    print('BedTemp={0:0.1f} ExtrTemp={1:0.1f}'.format(bedTemp,extrTemp))
except:
    print('Request Failed');
    pass
