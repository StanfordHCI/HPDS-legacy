from read_sql_remote_data import gen_df_from_remote_SQL
from read_csv_data import read_csv_data


def aActivities(df):
    print(df)


if __name__ == "__main__":

    # Sample credentials for a sample study that I setup on AWARE.
    # Credentials can be accessed on api.awareframework.com from
    # Study Dashboard > View Credentials.
    # Column names can be viewed by accessing
    hostname = "api.awareframework.com"
    username = "Ren_2425"
    password = "4kjUaIyK"
    database_name = "Ren_2425"

    # can access columsn using df['column name']
    df = gen_df_from_remote_SQL(hostname, username,
                                password, database_name, "plugin_ios_activity_recognition")
    aActivities(df)
