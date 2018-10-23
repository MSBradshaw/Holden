import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
import sys

f1d = pd.read_csv(str('first_digit' + str(sys.argv[1]) + '.csv'))

sns.set(style="whitegrid",rc={'figure.figsize':(11.7,8.27)})

b = sns.barplot(data=f1d, x="digit", y="Found")
b.axes.set_title('Distribution of First Digits: Sample 1',fontsize=30)
b.set_xlabel("First Digit",fontsize=20)
b.set_ylabel("Found %",fontsize=20)
fig = b.get_figure()
fig.savefig(str("sample_" + sys.argv[1] + "_first_digit_dist.png"))
