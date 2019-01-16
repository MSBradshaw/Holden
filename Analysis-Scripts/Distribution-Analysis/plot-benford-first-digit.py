import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
import sys
import re
import numpy as np

"""
parameters
1. input file
2. output file
3. graph title
4. "phony" or "real" default "phony". Plots the only the phony or real data
"""

def first_digit_after_decimal(data):
    original = data.copy()
    data = original.copy()
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
            char = data.iloc[i, j][0]
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
    ben_data.columns = ['digit_0', 'digit_1', 'digit_2', 'digit_3', 'digit_4', 'digit_5', 'digit_6', 'digit_7','digit_8', 'digit_9']
    return(ben_data)
    #return(original.join(ben_data,how='outer'))
df =  pd.read_csv(sys.argv[1])
# split up the data so you can look at the numerical distributions of the real and fake data seporatly
if sys.argv[4] == 'phony' :
    print('Phony')
    d = df[df.labels != 'phony']
    ben = first_digit_after_decimal(d)
else:
    print('Real')
    d = df[df.labels != 'real']
    ben = first_digit_after_decimal(d)

m = ben.mean()
a = m.to_frame()
a['Index'] = a.index.values
a.columns = ['score','Index']
df = a
sns.set(style="whitegrid",rc={'figure.figsize':(11.7,8.27)})
b = sns.barplot(data=df, x="Index", y="score")
b.axes.set_title(sys.argv[3],fontsize=30)
b.set_xlabel("First Digit",fontsize=20)
b.set_ylabel("Found %",fontsize=20)
fig = b.get_figure()
fig.savefig(sys.argv[2])

quit()
#(base) C:\Users\Michael\Documents\Holden2\Analysis-Scripts\Distribution-Analysis>python plot-benford-first-digit.py ..\..\Data\Random-Data-Set\Proteomics-100\test_proteomics_random1.csv random-proteomics-test-1-benford-plot-real.png Distribution\ of\ First\ Digit\ on\ Random\ Proteomic\ Data real
