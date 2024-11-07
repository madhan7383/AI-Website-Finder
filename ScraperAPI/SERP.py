import requests

payload = { 'api_key': '37b565f78bb379c0f95401dc1bbf232d', 'url': 'https://www.google.com/search?q=private+equity+info+Texas+USA', 'country_code': 'us', 'device_type': 'desktop' }
r = requests.get('https://api.scraperapi.com/', params=payload)
print(r.text)
