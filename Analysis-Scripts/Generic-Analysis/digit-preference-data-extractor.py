import pandas as pd
import time
import numpy as np
import re
import sys

sys.path.insert(0, '/mnt/c/Users/Michael/Documents/Holden2')
import Classification_Utils as cu
import DigitPreferences as dig

def clean_data(df):
    names = df.columns.values
    names[-1] = 'labels'
    df.columns = names
    df = df.replace('nan',0)
    df = df.fillna(0)
    return(df)

df = pd.read_csv('/mnt/c/Users/Michael/Documents/Holden2/Data/Random-Data-Set/test_cna_random.csv')
df = clean_data(df)
labels = df['labels']
first_df = dig.digit_preference_first_after_dec(df)
first_df.to_csv('/mnt/c/Users/Michael/Documents/Holden2/Analysis-Scripts/Generic-Analysis/random-first-digits.csv')
