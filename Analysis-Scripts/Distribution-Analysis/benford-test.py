import benford as bf
import pandas as pd
import sys

df = pd.read_csv('../../Data/Distribution-Data-Set/train_cna_distribution.csv')
df = df.fillna(0)
a = df.iloc[int(sys.argv[1]),0:-1].values.tolist()

f1d = bf.first_digits(a, digs=1, decimals=8)
f1d['digit'] = [1,2,3,4,5,6,7,8,9]

f1d.to_csv(str('first_digit' + str(sys.argv[1]) + '.csv'))
