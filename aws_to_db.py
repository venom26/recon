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
currentDateTime = datetime.datetime.now()
connection = sqlite3.connect('aws.db')
cursor = connection.cursor()   
fname = sys.argv[1]
print(fname)
cursor.execute('CREATE TABLE IF NOT EXISTS "AWS" \
                        ( "Id" INT AUTO_INCREMENT,\
                            "host" TEXT ,\
                            "subject" TEXT ,\
                            "issuer" TEXT,\
                            "subject_CN" TEXT,\
                            "subject_alt_name" TEXT,\
                            PRIMARY KEY ("Id"))') 
# cursor.execute("delete from AWS")

cnt = 0
err = 0
with open(fname, errors='ignore') as user_file:
    #print(user_file)
    for jsonObj in user_file:
        #print('file read')
        try:
            something = json.loads(jsonObj)
            for k,v in something.items():
                    if k=="host":
                        h = v
                    if k=="certificateChain":
                        for cc in v:
                            sub = cc.get("subject")
                            issu = cc.get("issuer")
                            subcn = cc.get("subjectCN")
                            subaltnm = cc.get("subjectAltName")
                            # print(h,sub,issu,subcn,subaltnm)
                            cnt+=1
                            print(cnt)
                            cursor.execute("INSERT INTO AWS (host,subject,issuer,subject_CN,subject_alt_name) values (?,?,?,?,?)", (h,sub,issu,subcn,subaltnm))
        except Exception as e:
            print('error',e)
            err+=1
print('Error count: ', err)
connection.commit()
cursor.close()
connection.close()
