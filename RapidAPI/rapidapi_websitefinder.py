import requests

url = "https://open-ai21.p.rapidapi.com/chatgpt"

payload = {
	"messages": [
		{
			"role": "user",
			"content": "find website of LOFTEY LLC 151 W 25Th Street 11Th Fl ,New York"
		}
	],
	"web_access": True
}
headers = {
	"x-rapidapi-key": "key",
	"x-rapidapi-host": "open-ai21.p.rapidapi.com",
	"Content-Type": "application/json"
}

response = requests.post(url, json=payload, headers=headers)

print(response.json())