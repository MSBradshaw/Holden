import pandas as pd
import re
import numpy as np
from ggplot import *
df = pd.read_csv('../../Data/Distribution-Data-Set/train_cna_distribution.csv')
df_test = pd.read_csv('../../Data/Distribution-Data-Set/test_cna_distribution.csv')

labels = df['labels']
df = df.drop(columns=['labels'])
df = df.fillna(0)
a = df

col_names = list(a.columns.values)

# convert all numbers to strings and get just the decimal portion
pattern = re.compile(r'-?\d\.')
for i in range(0,len(col_names)):
    col = a[col_names[i]].tolist()
    str_col = [str(j) for j in col]
    for j in range(0,len(col)):
        str_col[j] = pattern.sub('',str_col[j])
    a[col_names[i]] = str_col
print(a)

ben_data = pd.DataFrame(columns=range(0, len(a.index)))

# for each row
for i in range(0, len(a.index.tolist())):
    # for each item in row
    counts = np.array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    for j in range(0, len(a.columns)):
        # get first character
        char = a.iloc[i,j][0]
        #if it is the start of an NA name it 0
        if not char.isdigit():
            if char == '-':
                char = a.iloc[i,j][1]
            else:
                char = 0
        counts[int(char)] += 1
        #print(a.iloc[i,j][0])
    ben_data[i] = counts / len(a.columns.tolist())

print(ben_data.T.head())

def second_digit_after_decimal(data):
    original = data
    col_names = list(data.columns.values)

    # convert all numbers to strings and get just the decimal portion
    pattern = re.compile(r'-?\d\.')
    for i in range(0, len(col_names)):
        col = data[col_names[i]].tolist()
        str_col = [str(j) for j in col]
        for j in range(0, len(col)):
            str_col[j] = pattern.sub('', str_col[j])
        data[col_names[i]] = str_col

    ben_data = pd.DataFrame(columns=range(0, len(data.index)))

    # for each row
    for i in range(0, len(data.index.tolist())):
        # for each item in row
        counts = np.array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

        for j in range(0, len(data.columns)):
            # get first character
            if(len(data.iloc[i, j]) > 1):
                char = data.iloc[i, j][1]
            else:
                char = '0'
            # if it is the start of an NA name it 0
            if not char.isdigit():
                if char == '-':
                    char = data.iloc[i, j][1]
                else:
                    char = 0
            counts[int(char)] += 1
            # print(a.iloc[i,j][0])
        ben_data[i] = counts / len(data.columns.tolist())
    ben_data = ben_data.T
    ben_data.columns = ['digit_0', 'digit_1', 'digit_2', 'digit_3', 'digit_4', 'digit_5', 'digit_6', 'digit_7',
                    'digit_8', 'digit_9']
    return(ben_data)

dd = second_digit_after_decimal(df)

for i in range(0, len(dd.index.tolist())):
    data = dd.iloc[i, :].tolist()
    names = dd.columns.values.tolist()
    d = pd.DataFrame(columns=['digit', 'percent'])
    d['digit'] = names
    d['percent'] = data
    plot = ggplot(aes(x='digit', weight='percent'), data=d) + geom_bar()
    plot.save('Second-Digit-After-Decimanl-Plots/Sample-Plot-' + str(i) + '.png')
