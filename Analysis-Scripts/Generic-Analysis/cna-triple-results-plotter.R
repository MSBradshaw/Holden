library(readr)
library(tibble)
library(ggplot2)
library(dplyr)

#read in all the CNA Benford stuff
ran <- read_csv('Holden/Analysis-Scripts/Generic-Analysis/random-cna-results/random-cna-results-1.csv')
for(i in seq(2:50)){
  temp <- read_csv(paste('Holden/Analysis-Scripts/Generic-Analysis/random-cna-results/random-cna-results-',i,'.csv',sep=''))
  ran <- bind_rows(ran,temp)
}

ran = ran[ran$learner != 'MLP',]
ran = ran[ran$learner != 'SVC',]
ran$type = rep('random',nrow(ran))

#read in resampling data
res <- read_csv('Holden/Analysis-Scripts/Generic-Analysis/cna-resampling-results/resample-cna-1.csv')
for(i in seq(2:50)){
  temp <- read_csv(paste('Holden/Analysis-Scripts/Generic-Analysis/cna-resampling-results/resample-cna-',i,'.csv',sep=''))
  res <- bind_rows(res,temp)
}

res = res[res$learner != 'MLP',]
res = res[res$learner != 'SVC',]
res$type = rep('resampled',nrow(res))

#read in resampling data
imp <- read_csv('Holden/Analysis-Scripts/Generic-Analysis/imputation-cna-results/imputation-cna-results-4.csv')
for(i in seq(5,50)){
  temp <- read_csv(paste('Holden/Analysis-Scripts/Generic-Analysis/imputation-cna-results/imputation-cna-results-',i,'.csv',sep=''))
  imp <- bind_rows(imp,temp)
}

#remove the MLP and SVC from the results because they are crappy
imp = imp[imp$learner != 'MLP',]
imp = imp[imp$learner != 'SVC',]
imp$type = rep('imputation',nrow(imp))

comb = bind_rows(imp,res,ran)

p <- ggplot(comb, aes(x=type, y=score, fill=learner, color=learner)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=8,
               outlier.size=2,alpha = 0.5,notch = TRUE) + 
  ggtitle('Digit Preference Accuracy') + 
  ylab('Accuracy') +
  xlab('Learner') + ylim(0.0,1.0) +
  scale_x_discrete(c('Data Sets','f','d'),waiver(),c('Random','Resampled','Imputaion'),c('random','resampled','imputation'))
p
ggsave('Holden/Analysis-Scripts/Generic-Analysis/cna-triple-results.png',width = 15, height = 10, units = c("in"))
