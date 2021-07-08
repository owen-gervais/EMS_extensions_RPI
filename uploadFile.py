import requests
import binascii
import sys
import os

'''
uploadFileToOctoprint():

    Inputs:
        
        fileName: name of the file stored locally, or response object
                  
        fileContent: Response object or file content stored locally
                  
    Usage:
    
        This function connects to the Thingworx API endpoint
        to download files uploaded by the user to a custom
        project File Repository.
        
        The user will supply a repository name and file and
        the file will be downloaded locally. 

        IMPORTANT: This function works for text based files
        
         i.e. .py, .txt, .gcode files 

'''
def uploadFileToOctoprint(fileName:str, fileContent:str) -> bool: 
    # Create a unique boundary for the form body
    boundary = binascii.hexlify(os.urandom(16)).decode('ascii')
    
    # Form the body of the request
    body = (
         "".join("--%s\r\n"
                 "Content-Disposition: form-data; name=\"%s\"; filename=\"%s\"\r\n"
                 "Content-Type: application/octet-stream\r\n"
                 "\r\n"
                 "%s\r\n" % (boundary, "file", fileName, fileContent)) +
             "--%s--\r\n" % boundary
        )

    # Define the content_type
    content_type = "multipart/form-data; boundary=%s" % boundary

    # Url parameters
    base = 'http://octopi.local'
    url = '/api/files/local'

    # Establish the headers and API key
    headers = {
        'X-Api-Key': os.getenv('OCTOPI_KEY'),
        'Content-Type': content_type,
        'Content-Length': str(sys.getsizeof(body))
        }

    payload = body

    params = {}

    response = requests.request("POST", base+url, params=params, headers=headers, data=payload)
    
    