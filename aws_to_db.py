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
from urllib.parse import urlsplit
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

index_check_query = "SELECT * FROM sqlite_master WHERE name = 'host_index' and type = 'index'"
index_exists = cursor.execute(index_check_query).fetchone()

if not index_exists:
    cursor.execute("CREATE INDEX host_index ON AWS(host)")
else:
    print("Index host_index already exists, proceeding with further workflow")

index_check_query = "SELECT * FROM sqlite_master WHERE name = 'domain_name_index' and type = 'index'"
index_exists = cursor.execute(index_check_query).fetchone()

if not index_exists:
    cursor.execute("CREATE INDEX domain_name_index ON AWS(domain_name)")
else:
    print("Index domain_name_index already exists, proceeding with further workflow")


index_check_query = "SELECT * FROM sqlite_master WHERE name = 'issuer_index' and type = 'index'"
index_exists = cursor.execute(index_check_query).fetchone()

if not index_exists:
    cursor.execute("CREATE INDEX issuer_index ON AWS(issuer)")
else:
    print("Index issuer_index already exists, proceeding with further workflow")


# Create the "SubjectAltName" table
cursor.execute('''
CREATE TABLE IF NOT EXISTS "SubjectAltName" (
    "Id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "subdomain" TEXT ,
    "aws_id" INTEGER,
    FOREIGN KEY (aws_id) REFERENCES AWS(Id)
)''')
index_check_query = "SELECT * FROM sqlite_master WHERE name = 'idx_subdomain' and type = 'index'"
index_exists = cursor.execute(index_check_query).fetchone()

if not index_exists:
    cursor.execute('CREATE UNIQUE INDEX idx_subdomain ON SubjectAltName (subdomain);')
else:
    print("Index idx_subdomain already exists, proceeding with further workflow")

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

def extract_root_domain(subdomain):
    url = 'http://' + subdomain
    url_parts = urlsplit(url)
    domain = url_parts.hostname
    return domain

def extract_domain_name(subdomain):
    pattern = r"(?:[a-zA-Z0-9](?:[a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,6}"
    match = re.search(pattern, subdomain)
    if match:
        extracted = tldextract.extract(subdomain)
        domain_name = extracted.domain + '.' + extracted.suffix
    else:
        domain_name = ""
    return domain_name

def extract_subdomains(string):
    if string is None:
        return []
    subdomains = string.replace("DNS:", "")
    subdomains = subdomains.split(', ')
    subdomains = [sub.replace('*.','') for sub in subdomains]
    subdomains = list(set(subdomains))
    return subdomains

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
                    cc = v[0]
                    sub = cc.get("subject")
                    issu = extract_organization(cc.get("issuer"))
                    subcn = cc.get("subjectCN")
                    subaltnm = cc.get("subjectAltName")
                    domain_name = extract_domain_name(extract_root_domain(str(subcn)))
                    cnt+=1
                    cursor.execute("INSERT INTO AWS (host,subject,issuer,subject_CN, domain_name) values (?,?,?,?,?)", (h,sub,issu,subcn, domain_name))
                    subdomains = extract_subdomains(subaltnm)
                    for subdomain in subdomains:
                        try:
                            cursor.execute("INSERT INTO SubjectAltName (aws_id,subdomain) values (?,?)", (cnt,subdomain))
                        except sqlite3.IntegrityError:
                            pass
        except Exception as e:
            print('error',e)
            print('domain name: ', domain_name)
            print('Host:', h)
            print('##############################################################')
            err+=1
print('Error count: ', err)
connection.commit()
cursor.close()
connection.close()
