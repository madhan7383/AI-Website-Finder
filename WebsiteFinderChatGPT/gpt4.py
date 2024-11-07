import openai

# Replace 'your-api-key' with your actual OpenAI API key
openai.api_key = 'your-api-key'

def find_company_website(company_name, address):
    prompt = (
        f"I need to find the official website address of the company named {company_name} "
        f"located at {address}. The company is a consulting group in New York. "
        f"Please provide the most accurate website address."
    )

    response = openai.ChatCompletion.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": prompt}
        ],
        max_tokens=100,
        n=1,
        stop=None,
        temperature=0.7
    )

    return response['choices'][0]['message']['content'].strip()

if __name__ == "__main__":
    company_name = "LOGOS CONSULTING GROUP, LLC"
    address = "875 Avenue Of The Americas, New York"
    website = find_company_website(company_name, address)
    print(f"The website address for {company_name} at {address} is: {website}")
