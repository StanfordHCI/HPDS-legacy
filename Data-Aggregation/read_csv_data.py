import pandas as pd


'''
Reads data from a .csv file containing building data (view sample
in this directory) or Qualtrics survey daya into a pandas dataframe
for analysis.
'''


def read_csv_data(filename):
    # header parameter determines which row of the .csv is to be used
    # as the headers for the dataframe. As you can see from the sample
    # data, that is row 1; other building data may not conform to this
    # format, and so the header parameter may need to be adjusted
    # accordingly.
    df = pd.read_csv(filename, header=1)
    return df


if __name__ == "__main__":
    print(read_building_data("sample_buildingdata.csv"))
