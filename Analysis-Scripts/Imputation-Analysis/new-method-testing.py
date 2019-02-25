import pandas as pd
import time
import numpy as np
import re
import sys

sys.path.insert(0, '/mnt/c/Users/Michael/Documents/Holden')
import Classification_Utils as cu
import DigitPreferences as dig

df = pd.read_csv('../../Data/Imputation-Data-Set/CNA-imputation-train.csv')
def clean_data(df):
    names = df.columns.values
    names[-1] = 'labels'
    df.columns = names
    df = df.replace('nan',0)
    df = df.fillna(0)
    return(df)
ben = dig.digit_preference_first_after_dec(df)
#this works, the results are the same

d = first_digit_after_decimal(df)
