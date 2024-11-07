import openai

# Set OpenAI API key
openai.api_key = "your-api-key"

# Model and generation parameters
model = "gpt-4"
temperature = 0.7
max_tokens = 100

# Read input file
with open("prompt.txt", "r") as f:
    lines = f.readlines()

# Open output file
with open("descriptions.txt", "a") as desc_file:
    # Process each line in the input file
    for line in lines:
        no, firm, address = line.strip().split('\t')  # Adjust this based on your delimiter

        print("ID:", no)
        print("Address:", address)
        print("Firmname:", firm)

        firm = firm.title()
        
        prompt = f'Find the website address of company name is {firm} and located at {address}'

        try:
            response = openai.ChatCompletion.create(
                model=model,
                messages=[
                    {"role": "system", "content": "You are a helpful assistant."},
                    {"role": "user", "content": prompt}
                ],
                temperature=temperature,
                max_tokens=max_tokens
            )
            
            description = response.choices[0].message['content'].strip()
            
            print("Prompt:", prompt)
            print("Description:", description)
            
            # Check if the description is empty
            if not description:
                print(f"No description generated for firm: {firm}")
                continue
            
            # Write the description to the output file
            desc_file.write(f"{firm}\t{description}\n")
        
        except Exception as e:
            print(f"An error occurred: {e}")
