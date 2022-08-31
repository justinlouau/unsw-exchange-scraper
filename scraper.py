#!/usr/bin/env python3
import sys, re
import subprocess
import requests
import csv

# s = subprocess.call(['sh', './scraper.sh'])

with open('partner_urls.txt') as f:
    lines = f.readlines()

exchange_csv = open('exchange.csv', 'w', newline ='')
header = ['University', 'Term of study', 'Destination', 'Type of study', 'Faculty', 'Language of instruction', 'Level']
write = csv.writer(exchange_csv)
write.writerow(header)

for partner_uni in lines:
    r = requests.get("http://www.student.unsw.edu.au/partners/" + partner_uni.strip())

    info = -1
    info_list = [[],[],[],[],[],[],[]]
    for i, line in enumerate(r.text.splitlines()):
        if re.search("Term of study|Destination|Type of study|Faculty|Language of instruction|Level|<span>|</span>|<title>", line):
            if "title" in line: 
                info = 0
                line = line.split('|', 1)[0]

            line = re.sub('<.*?>', '', line)
            line = line.strip()

            if "Term of study" in line:
                info = 1
                continue
            elif "Destination" in line:
                info = 2
                continue
            elif "Type of study" in line:
                info = 3
                continue
            elif "Faculty" in line:
                info = 4
                continue
            elif "Language of instruction" in line:
                info = 5
                continue
            elif "Level" in line:
                info = 6
                continue

            if info >= 0:
                # print(line, info_list)
                info_list[info].append(line)

                if info == 0:
                    info = -1
    
    i = 0
    while (i < len(info_list)):
        info_list[i] = " ".join(info_list[i])
        info_list[i] = info_list[i].strip()
        i += 1

    print(info_list)
    write.writerow(info_list)

    # if partner_uni.strip() == 'college-charleston':
    #     break

# with exchange_csv:
#     # identifying header 
#     header = ['University', 'Term of study', 'Destination', 'Type of study', 'Faculty', 'Language of instruction', 'Level']

#     write = csv.writer(exchange_csv)
#     write.writerow(header)
#     write.writerow(info_list)