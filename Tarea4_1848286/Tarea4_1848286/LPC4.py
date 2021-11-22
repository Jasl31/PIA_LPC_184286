import requests
from bs4 import BeautifulSoup
import csv

URL = "https://realpython.github.io/fake-jobs/"
page = requests.get (URL)

soup = BeautifulSoup(page.content, "html.parser")
results = soup.find(id="ResultsContainer")

job_elements = results.find_all("div", class_="card-content")
python_jobs = results.find_all ("h2", string=lambda text: "python" in text.lower())

titles = list()
companies = list()
locations = list()

for job_element in job_elements:
        title_element = job_element.find("h2", class_="title")
        company_element = job_element.find("h3", class_="company")
        location_element = job_element.find("p", class_="location")

        link_url = job_element.find_all("a")[1]["href"]
        links = job_element.find_all('a')
        print (company_element.text.strip())
        print (location_element.text.strip())
        print (title_element.text.strip())

        print(f"ApplyHere: {link_url}\n")
        print()

        for title in title_element:
           titles.append(title_element.text.strip())

        for company in company_element:
           companies.append(company_element.text.strip())


        for location in location_element:
             locations.append(location_element.text.strip())

        with open('./Data.csv', 'w') as csv_file:
          csv_writer = csv.writer(csv_file, dialect='excel')
          csv_writer.writerows(zip(titles,companies,locations))

        
        

