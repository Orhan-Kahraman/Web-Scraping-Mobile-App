# Python program to scrape website
# and save quotes from website
import json
from asyncore import read
from multiprocessing.sharedctypes import Value
from operator import index
import requests
from bs4 import BeautifulSoup
import csv
from pprint import pprint


class ScrapingThing:
    def get_computer_information_all(self, url_listesi):

        i = 0
        for link in url_listesi:
            print(link)
            i += 1
            read = requests.get(link)

            bilgisayar_bilgisi = {}
            bilgisayar_bilgisi['Bilgisayarın ismi'] = self.get_pcname(link)
            bilgisayar_bilgisi['Bilgisayar Adresi'] = link
            bilgisayar_bilgisi['Fiyat'] = self.get_price(link)

            soupe = BeautifulSoup(read.content, 'html5lib')
            ules = soupe.find('ul', attrs={'class': 'detail-attr-container'})

            for item in ules.find_all('li', attrs={'class': 'detail-attr-item'}):

                bilgisayar_bilgisi['{}'.format(item.span.text)] = item.b.text

            cps_info.append(bilgisayar_bilgisi)
            # print(bilgisayar_bilgisi)
            # print(soupe)
            print("Done")
            if i == 2:
                break

    def get_price(self, url):
        read = requests.get(url)
        soupe = BeautifulSoup(read.content, 'html5lib')
        price = soupe.find('span', attrs={'class': 'prc-dsc'})
        return price.text

    def get_pcname(self, url):
        read = requests.get(url)
        soupe = BeautifulSoup(read.content, 'html5lib')
        pc_name = soupe.find('h1', attrs={'class': 'pr-new-br'})
        return pc_name.text


URL = "https://www.trendyol.com/laptop-x-c103108"
r = requests.get(URL)

soup = BeautifulSoup(r.content, 'html5lib')

links = []

table = soup.find('div', attrs={'class': 'prdct-cntnr-wrppr'})

cps_info = []

for row in table.findAll('div', attrs={'class': 'p-card-chldrn-cntnr card-border'}):

    links.append("https://www.trendyol.com/" + row.a['href'])


trendyol_notebook = ScrapingThing()

trendyol_notebook.get_computer_information_all(links)

# pprint(cps_info)
# print(len(cps_info))
#cps_info = list(cps_info)
print(type(cps_info))
# set(cps_info)
print(len(cps_info))

# pprint(cps_info)

json_opject = json.dumps(cps_info, indent=4, ensure_ascii=False)
print(json_opject)

with open("pc_info.json", "w", encoding='utf-8') as outfile:
    json.dump(cps_info, outfile, ensure_ascii=False, indent=4,)
