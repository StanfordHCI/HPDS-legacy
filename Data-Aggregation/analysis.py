from read_sql_remote_data import gen_df_from_remote_SQL
from read_csv_data import read_csv_data
import numpy
import matplotlib.pyplot as plt


# analyze plugin_ios_activity_recognition data from AWARE server SQL database.
def activitiesAnalysis(df):
    # print(df)
    plt.close('all')
    gdf = df.groupby("activities")  # group by activities type for aggregate
    actMap = {}
    # create a map that links activities type to frequency
    for key, item in gdf:
        actMap[key] = len(gdf.get_group(key))
    labels = list(actMap.keys())
    sizes = list(actMap.values())
    fig1, ax1 = plt.subplots()
    ax1.pie(sizes, labels=labels, autopct='%1.1f%%',
            startangle=90)
    # Equal aspect ratio ensures that pie is drawn as a circle.
    ax1.axis('equal')
    plt.show()


# analyze healthkit quantity data from AWARE server SQL database.
def healthQuanAnalysis(df):
    hdf = df.groupby(["device_id", "type"])
    # displays the entries of each HealthKit type grouped by type
    for key, item in hdf:
        print(hdf.get_group(key), "\n\n")


# analyze healthkit category data from AWARE server SQL database.
def healthCatAnalysis(df):
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
    # healcatdf = gen_df_from_remote_SQL(hostname, username,
    # password, database_name, "health_kit_category")
    # qualdf = read_csv_data('yah yeet_July 8, 2019_16.24.csv')

    # qualtricsAnalysis(qualdf)
    # activitiesAnalysis(actdf)
    healthQuanAnalysis(healquandf)
    # healthCatAnalysis(healcatdf)
