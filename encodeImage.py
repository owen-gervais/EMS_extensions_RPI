import base64
import urllib.request

urllib.request.urlretrieve("http://octopi.local/webcam/?action=snapshot", '/home/pi/picture.jpg')

with open('/home/pi/picture.jpg', 'rb') as image_file:
    encoded_string = base64.b64encode(image_file.read())
    
imgEncodedString = encoded_string

imgString = imgEncodedString.decode('utf-8')
print(imgString)