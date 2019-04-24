import pandas as pd
import numpy as np
from scipy.stats.stats import pearsonr

cna = pd.read_csv('CNA.cct',sep='\t')
names = cna['idx']
cna = cna.drop(['idx'],1)
#convert to np array
cna = np.transpose(cna.values)
best_index = (0,0)
best = 0
second_best_index = (0,0)
second_best = 0

for i in range(cna.shape[1]-1):
    for j in range(i+1,cna.shape[1]):
        if i is j:
            continue
        score = abs(pearsonr(cna[:,i],cna[:,j])[0])
        if score > best:
            second_best = best
            second_best_index = best_index
            best = score
            best_index = (i,j)
        elif score > second_best and (i,j) is not second_best_index and (j,i) is not second_best_index:
            second_best = score
            second_best_index = (i,j)

print('Best: ', str(best), ' ', str(best_index))
print('Second Best: ', str(best), ' ', str(best_index))
