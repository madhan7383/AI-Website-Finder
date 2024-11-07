import google.generativeai as genai
import requests
import re
import time

generation_config = {
  "temperature": 0.9,
  "top_p": 1,
  "top_k": 0,
  "max_output_tokens": 2048,
  "response_mime_type": "text/plain",
}

model = genai.GenerativeModel(
  model_name="gemini-1.0-pro-001",
  generation_config=generation_config,
)

with open("prompt.txt", encoding='utf-8', errors='ignore' "r") as f:
    for line in f:
        no, firm, address = line.strip().split('\t')  # Adjust this based on your delimiter

        print("ID:", no)
        print("Address:", address)
        print("Firmname:", firm)

        palm.configure(api_key='your-api-key')
        
        
        retries = 3
        for attempt in range(retries):
            # Make the request
           
            chat_session = model.start_chat()
            #response = palm.chat(messages='Find the website address of company name ' + firm +' and located in ' + address +'', **defaults)
            response = chat_session.send_message('Find the website address of company name ' + firm +' and located in ' + address +'')
            print(response.text)
            #print ("reps", response)
            # Check if the response indicates success
            if response.messages[0]['content']:
                description = response
                #print("Business Description:", description)
                break  # Break out of the retry loop if successful
            else:
                print(f"Attempt {attempt+1} failed. Retrying...")
                time.sleep(1)  # Wait for 1 second before retrying

        # Check if all retries failed
        if not response.messages[0]['content']:
            print(f"Error after {retries} attempts. Status: {response.status}")

        print("Description:", description)

            
        if not isinstance(description, str):
            description = str(description)
        #  "}], filters=[], top_p=0. 95, top_k=40)
        # Clean up the description
        
        description = description.strip()
        #print("Description: ", description)
        # Check if the description is empty
        if not description:
            print("No description generated for website: ", no)
            continue

        # Write the description to a text file
        with open("descriptions_Palm.txt", "a") as f:
            f.write(no + "\t" + firm + "\t" + address + "\t" + description + "\n")
