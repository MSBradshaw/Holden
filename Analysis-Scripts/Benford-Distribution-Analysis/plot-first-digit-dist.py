import numpy as np
import pandas as pd
import sys
import seaborn as sns

#this is to import my custom python module for digit preference extraction
sys.path.insert(0, '/mnt/c/Users/Michael/Documents/Holden')
import DigitPreferences as dig

'''
This script requires two arguments
1 input file
2 name of the output plot (please make it a png, other wise you are a fool)
'''

df_fat = pd.read_csv(sys.argv[1],delimiter=',')

pd_f = dig.digit_preference_first_after_dec(df_fat,tidy_out=True)

sns.set(style="whitegrid")
ax = sns.barplot(x="digit", y="freq",hue="labels", data=pd_f)
ax.figure.savefig(sys.argv[2])

#../../Data/Distribution-Data-Set/CNA-100/test_cna_distribution1.csv
