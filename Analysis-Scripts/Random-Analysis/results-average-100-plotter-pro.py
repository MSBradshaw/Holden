import pandas as pd
import matplotlib.pyplot as plt

#read in the 100 results files

data = pd.read_csv('ProteomicsResults/proteomics_results1.csv')

for i in range(2,101):
        temp = pd.read_csv('ProteomicsResults/proteomics_results' + str(i) + '.csv')
        data = data.append(temp)

data = data.reset_index(drop=True)
data = data.drop(columns='Unnamed: 0')
mean = data.groupby('learner').mean()
std = data.groupby('learner').std()
combind = pd.merge(mean, std, left_index=True, right_index=True)
combind.columns = ['mean','std']
combind['Index'] = combind.index.values
#define the size of the plot
fig, ax = plt.subplots(figsize=(11,8.5))
x_position = list(range(0,len(combind.index)))
ax.bar(x_position, combind['mean'].tolist(), yerr=combind['std'].tolist(), align='center', alpha=0.5, ecolor='black', capsize=10)
ax.set_xticks(x_position)
ax.set_ylabel('% Accuracy')
ax.set_xticklabels(combind['Index'])
ax.set_title('Mean Accuracy of Learners on 100 Resampling Proteomics Datasets')
ax.yaxis.grid(True)
# Save the figure and show
plt.tight_layout()
plt.savefig('proteomics-resampling-100-barplot.png',dpi=100)
plt.show()
            
