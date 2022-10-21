import string
from typing_extensions import Self
import requests
import html5lib
from bs4 import BeautifulSoup


class MedlineScraper:
    def __init__(self):
        self.base_url = "https://www.trendyol.com/laptop-x-c103108"

    def get_source(self):
        r = requests.get(self.base_url)
        if r.status_code == 200:
            return BeautifulSoup(r.content, "html5lib")
        return False

    def get_all_notebooks(self, source):
        allnotebooks = source.find(
            "div", attrs={"class": "p-card-chldrn-cntnr card-border"}).find_all()

        #notebooks_links = list(map(lambda links: links.find('a').get("href"), allnotebooks))
        return allnotebooks


if __name__ == '__main__':
    scraper = MedlineScraper()
    # print(scraper.get_caterories())

    source = scraper.get_source()
    print(source.prettify)
    # print(scraper.get_all_notebooks(source))
