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

1. batch: (Array of Strings) Y Combinator batches to filter by (e.g., ["S24", "S21"]).
2. industry: (String) Industry to filter by (e.g., "Fintech").
3. regions: (String) Regions to filter by (e.g., "East Asia").
4. top_company: (Boolean) Filter for top companies (e.g., true).
5. company_size: (String) Company size to filter by (e.g., "1-10").
6. isHiring: (Boolean) Filter for companies that are hiring (e.g., true).
7. nonprofit: (Boolean) Filter for nonprofit companies (e.g., true).
8. highlight_black: (Boolean) Filter for companies focusing on Black entrepreneurs (e.g., true).
9. highlight_latinx: (Boolean) Filter for companies focusing on Latinx entrepreneurs (e.g., false).
10. highlight_women: (Boolean) Filter for companies focusing on women entrepreneurs (e.g., true).


# Project Setup
1. Clone Repo - git clone https://github.com/ankitrathoretech/scrapper.git
2. Install Dependencies - bundle install
3. Set Up the Database - rails db:create
                         rails db:migrate
4. Start Rails Server - rails s
5. Access the API - http://localhost:3000/scrape

   
# How to Test
You can test the API using Postman or any HTTP client of your choice. Follow these steps in Postman:

1. Set the Request Method: POST
2. Enter the URL: http://127.0.0.1:3000/scrape
3. Set Headers:
4. Content-Type: application/json
5. Specify the Body:
6. Select raw and paste your JSON payload into the body section.
7. Send the Request: Click the Send button to make the request.


