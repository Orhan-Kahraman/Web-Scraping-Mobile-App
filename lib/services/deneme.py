# Python program to scrape website
# and save quotes from website

from asyncore import read
from multiprocessing.sharedctypes import Value
from operator import index
import requests
from bs4 import BeautifulSoup
import csv
from pprint import pprint


class ScrapingThing:
    def bilgisayarlarin_siteleri(self, url_listesi):

        i = 0
        for link in url_listesi:
            print(link)
            i += 1
            read = requests.get(link)

            bilgisayar_bilgisi = {}
            bilgisayar_bilgisi['Bilgisayar Adresi'] = link
            bilgisayar_bilgisi['Fiyat'] = self.get_price(link)
            soupe = BeautifulSoup(read.content, 'html5lib')
            ules = soupe.find('ul', attrs={'class': 'detail-attr-container'})

            for item in ules.find_all('li', attrs='detail-attr-item'):

                bilgisayar_bilgisi['{}'.format(item.span.text)] = item.b.text

            cps_info.append(bilgisayar_bilgisi)
            # print(bilgisayar_bilgisi)
            # print(soupe)
            print("Done")
            if i == 5:
                break

    def get_price(self, url):
        read = requests.get(url)
        soupe = BeautifulSoup(read.content, 'html5lib')
        price = soupe.find('span', attrs={'class': 'prc-dsc'})
        return price.text


URL = "https://www.trendyol.com/laptop-x-c103108"
r = requests.get(URL)

soup = BeautifulSoup(r.content, 'html5lib')

links = []  # a list to store quotes
bilgisayar_isimleri = []
table = soup.find('div', attrs={'class': 'prdct-cntnr-wrppr'})

cps_info = []

for row in table.findAll('div', attrs={'class': 'p-card-chldrn-cntnr card-border'}):
    quote = {}
    #quote['theme'] = row.h5.text
    # quote['url'] =
    #quote['img'] = row.img['src']
    # quote['lines'] = row.img['alt'].split(" #")[0]
    # quote['author'] = row.img['alt'].split(" #")[1]
    links.append("https://www.trendyol.com/" + row.a['href'])
    bilgisayar_isimleri.append(row.a['href'])

trendyol_notebook = ScrapingThing()

trendyol_notebook.bilgisayarlarin_siteleri(links)

# pprint(cps_info)
# print(len(cps_info))
#cps_info = list(cps_info)
print(type(cps_info))
# set(cps_info)
print(len(cps_info))
# print(bilgisayar_isimleri)
pprint(cps_info)
