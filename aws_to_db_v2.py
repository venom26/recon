# 10 Times faster

import sqlite3
import requests
import json
import os
import random
import sys
import pandas as pd
from glob import glob
import sys
import datetime
import ast
import tldextract
import re

currentDateTime = datetime.datetime.now()
connection = sqlite3.connect('aws.db')
cursor = connection.cursor()   
fname = sys.argv[1]
print(fname)
cursor.execute('CREATE TABLE IF NOT EXISTS "AWS" \
                        ( "Id" INTEGER PRIMARY KEY AUTOINCREMENT,\
                            "host" TEXT ,\
                            "subject" TEXT ,\
                            "issuer" TEXT,\
                            "subject_CN" TEXT,\
                            "subject_alt_name" TEXT,\
                            "domain_name" TEXT)') 
cursor.execute("CREATE INDEX host_index ON AWS(host)")
cursor.execute("CREATE INDEX domain_name_index ON AWS(domain_name)")
cursor.execute("CREATE INDEX issuer_index ON AWS(issuer)")
# cursor.execute("delete from AWS")

cnt = 0
err = 0

# Extract domain name from subdomain
def extract_domain(string):
    pattern = r"(?:CN=|DNS:)?([\w|\*|\.]+)"
    match = re.search(pattern, string)
    if match:
        domain = match.group(1)
    else:
        domain = None
    return domain


def extract_domain_name(subdomain):
    extracted = tldextract.extract(subdomain)
    domain_name = extracted.domain + '.' + extracted.suffix
    return domain_name


def extract_organization(string):
    pattern = r"O=([\w|\s|,|\.]+);"
    match = re.search(pattern, string)
    if match:
        organization = match.group(1)
    else:
        organization = None
    return organization

with open(fname, errors='ignore') as user_file:
    for jsonObj in user_file:
        try:
            something = json.loads(jsonObj)
            for k,v in something.items():
                if k=="host":
                    h = v
                if k=="certificateChain":
                    for cc in v:
                        sub = cc.get("subject")
                        issu = extract_organization(cc.get("issuer"))
                        subcn = cc.get("subjectCN")
                        subaltnm = cc.get("subjectAltName")
                        domain_name = extract_domain_name(extract_domain(str(subcn)))
                        cnt+=1
                        cursor.execute("INSERT INTO AWS (host,subject,issuer,subject_CN,subject_alt_name, domain_name) values (?,?,?,?,?,?)", (h,sub,issu,subcn,subaltnm, domain_name))
        except Exception as e:
            print('error',e)
            print('domain name: ', domain_name)
            err+=1
print('Error count: ', err)
connection.commit()
cursor.close()
connection.close()
