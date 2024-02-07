import pandas as pd 
import matplotlib.pyplot as plt 
import seaborn as sns 

'''
Data needs to be cleaned up first
'''
data_paths = {
    'Los Angeles' : ' ',
    'New York' : ' ',
    'Denver' : ' ',
    'Boston' : ' ',
    'Chicago' : ' ',
    'Austin' : ' ',
}

def collect_data(paths):
    df_list = []
    for city, path in paths.items():
        city_df = pd.read_csv(path)
        city_df['City'] = city
        df_list.append(city_df)
    combined_df = pd.concat(df_list, ignore_index = True)
    return combined_df

def clean_data(df):
    '''
    Cleans the combined DataFrame
    '''
    return df

def explore_data(df):
    # Distribution of prices
    plt.figure(figsize = (10,6))
    sns.histplot(df['price'], bins = 50, kde = True)
    plt.title('Distribution of Prices')
    plt.xlabel('Price')
    plt.ylabel('Frequency')
    plt.show()

    # Number of listings per city
    plt.figure(figsize = (10, 6))
    sns.countplot(x = 'City', data = df)
    plt.title(' Number of Listings per City')
    plt.xlabel('City')
    plt.ylabel('Number of Listings')
    plt.xticks(rotation = 45)
    plt.show()

if __name__ == '__main__':
    combined_data = collect_data(data_paths)
    cleaned_data = clean_data(combined_data)
    explore_data(cleaned_data)


