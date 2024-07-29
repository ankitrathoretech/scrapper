# README



# API Endpoint
URL: http://127.0.0.1:3000/scrape
Method: POST
Content-Type: application/json

For example(JSON)
{
  "n": 20,
  "filters": {
    "top_company": true,
    "isHiring": true
  }
}


# Parameters
n: (Integer) The number of companies to scrape. This field is required.

filters: (Object) A set of optional filters to apply to the data:

batch: (Array of Strings) Y Combinator batches to filter by (e.g., ["S24", "S21"]).
industry: (String) Industry to filter by (e.g., "Fintech").
regions: (String) Regions to filter by (e.g., "East Asia").
top_company: (Boolean) Filter for top companies (e.g., true).
company_size: (String) Company size to filter by (e.g., "1-10").
isHiring: (Boolean) Filter for companies that are hiring (e.g., true).
nonprofit: (Boolean) Filter for nonprofit companies (e.g., true).
highlight_black: (Boolean) Filter for companies focusing on Black entrepreneurs (e.g., true).
highlight_latinx: (Boolean) Filter for companies focusing on Latinx entrepreneurs (e.g., false).
highlight_women: (Boolean) Filter for companies focusing on women entrepreneurs (e.g., true).


# How to Test
You can test the API using Postman or any HTTP client of your choice. Follow these steps in Postman:

Set the Request Method: POST
Enter the URL: http://127.0.0.1:3000/scrape
Set Headers:
Content-Type: application/json
Specify the Body:
Select raw and paste your JSON payload into the body section.
Send the Request: Click the Send button to make the request.
