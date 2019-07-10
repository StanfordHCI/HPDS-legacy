from read_sql_remote_data import gen_df_from_remote_SQL
from read_csv_data import read_csv_data


# analyze plugin_ios_activity_recognition data from AWARE server SQL database.
def activitiesAnalysis(df):
    act = df[df["activities"] != ""]  # remove empty entries
    print(act)


# analyze healthkit quantity data from AWARE server SQL database.
def healthQuanAnalysis(df):
    print(df)


# analyze qualtrics survey data
def qualtricsAnalysis(df):
    print(df)


if __name__ == "__main__":
    # credentials for PPS setup for AWARE.
    # Credentials can be accessed on api.awareframework.com
    hostname = "api.awareframework.com"
    username = "Ren_2425"
    password = "4kjUaIyK"
    database_name = "Ren_2425"

    actdf = gen_df_from_remote_SQL(hostname, username,
                                   password, database_name, "plugin_ios_activity_recognition")
    healquandf = gen_df_from_remote_SQL(hostname, username,
                                        password, database_name, "health_kit_quantity")
    qualdf = read_csv_data('yah yeet_July 8, 2019_16.24.csv')
    # Column names can be viewed by accessing df["column_name"]
    # qualtricsAnalysis(qualdf)
    activitiesAnalysis(actdf)
    healthQuanAnalysis(healquandf)
