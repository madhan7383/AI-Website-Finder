import requests

url = "https://google-api31.p.rapidapi.com/websearch"

payload = {
	"text": "KRISTEN CENTERS INC 93 Fairview Avenue ,Kingston",
	"safesearch": "on",
	"timelimit": "",
	"region": "en-us",
	"max_results": 5
}
headers = {
	"x-rapidapi-key": "key",
	"x-rapidapi-host": "google-api31.p.rapidapi.com",
	"Content-Type": "application/json"
}

response = requests.post(url, json=payload, headers=headers)

print(response.json())