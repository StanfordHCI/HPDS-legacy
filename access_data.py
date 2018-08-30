import pymysql
import pandas as pd

'''
Access data from remote SQL database (the example credentials use 
an AWARE backend database) using the provided credentials, then 
returns a pandas dataframe consisting of the data from SQL table 
table_name.
'''
def gen_pandas_dataframe(hostname, username, password, database_name, table_name, columnnames):
	pymysql.install_as_MySQLdb()
	conn = pymysql.connect(hostname, username, password, database_name)

	cursor = conn.cursor()
	cursor.execute("SELECT * FROM " + table_name)

	data = cursor.fetchall()
	data_list = []

	# Read rows from data into a list from which we can create the dataframe
	for row in data:
		data_list.append(row)

	df = pd.DataFrame(data_list)
	df.columns = columnnames

	return df

if __name__ == "__main__":

	# Sample credentials for a sample study that I setup on AWARE.
	# Credentials can be accessed on api.awareframework.com from 
	# Study Dashboard > View Credentials.
	# Column names can be viewed by accessing 
	hostname = "api.awareframework.com"
	username = "Cooper_1945"
	password = "" # password redacted
	database_name = "Cooper_1945"

	table_name = "accelerometer" # Table of interest
	columnnames = ["id", "timestamp", "device_id", "double_values_0", "double_values_1", "double_values_2", "accuracy", "label"] # Column names for AWARE accelerometer table

	print(gen_pandas_dataframe(hostname, username, password, database_name, table_name, columnnames))

