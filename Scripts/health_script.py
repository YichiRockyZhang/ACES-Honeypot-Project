import gspread
import os
from oauth2client.service_account import ServiceAccountCredentials

# use creds to create a client to interact with the Google Drive and Google Sheets API
scope = ["https://spreadsheets.google.com/feeds",'https://www.googleapis.com/auth/spreadsheets',"https://www.googleapis.com/auth/drive.file","https://www.googleapis.com/auth/drive"]
creds = ServiceAccountCredentials.from_json_keyfile_name('health_log_creds.json', scope)
client = gspread.authorize(creds)

# Put the name of your spreadsheet here
sheet = client.open("Health Logs").sheet1
os.system("./health_script.sh")

# Example of how to insert a row
file1 = open('./health.log', 'r')
row = file1.readlines()
index = sheet.row_count
sheet.append_row(row)
