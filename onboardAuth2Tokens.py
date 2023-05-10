import requests
import base64

CLIENT_ID='' #insert your client id
CLIENT_SECRET='' #insert your client secret
REDIRECTURI = '' #insert your redirect url
AUTHCODE = ''#auth code for a person who consented to give your fitbit app access to their fitbit data

def auth2tokens(authcode):
#Exchange auth code for access and refresh token
    clientCreds = CLIENT_ID + ":" + CLIENT_SECRET
    base64_bytes = clientCreds.encode('ascii') #encode w base 64
    message_bytes = base64.b64encode(base64_bytes)
    message = message_bytes.decode('ascii')

    auth = "Basic " + message
    headers = {'Authorization': auth, 'Content-Type' : 'application/x-www-form-urlencoded'}

    url = 'https://api.fitbit.com/oauth2/token'
    parameters = {'client_id' : CLIENT_ID, 'grant_type': 'authorization_code', 'redirect_uri': REDIRECTURI, 'code': AUTHCODE }

    r = requests.post(url,headers = headers, data = parameters)
    rdict = r.json()
  
    ACCESS_TOKEN = rdict['access_token']
    REFRESH_TOKEN = rdict['refresh_token']
    print(f'access {ACCESS_TOKEN}')
    print(f'refresh {REFRESH_TOKEN}')

    return

auth2tokens(AUTHCODE)




