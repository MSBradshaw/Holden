library(readr)
library(tibble)
library(ggplot2)
library(dplyr)
library(ggpubr)


#read in resampling data
dataImp <- read_csv('Holden/Analysis-Scripts/Generic-Analysis/imputation-cna-50-ff/imputation-cna-results-ff-4.csv')
for(i in seq(5,50)){
  temp <- read_csv(paste('Holden/Analysis-Scripts/Generic-Analysis/imputation-cna-50-ff/imputation-cna-results-ff-',i,'.csv',sep=''))
  dataImp <- bind_rows(dataImp,temp)
}
colnames(dataImp) <- c('X1','score','Learner')
dataImp[dataImp$Learner == 'Random Forest',]$Learner <- 'RF'
dataImp[dataImp$Learner == 'Naive Bayes',]$Learner <- 'NB'


impP <- ggplot(dataImp, aes(x=Learner, y=score, fill=Learner)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=8,
               outlier.size=2,alpha = 0.5,notch = TRUE) + 
  geom_jitter(shape=16, position=position_jitter(0.2),aes(color=Learner)) +
  ylab('Accuracy') +
  xlab('Learner') + ylim(0.0,1.0) 
impP

#read in resampling data
dataRan <- read_csv('Holden/Analysis-Scripts/Generic-Analysis/random-cna-50-ff/random-cna-results-ff-1.csv')
for(i in seq(2,50)){
  temp <- read_csv(paste('Holden/Analysis-Scripts/Generic-Analysis/random-cna-50-ff/random-cna-results-ff-',i,'.csv',sep=''))
  dataRan <- bind_rows(dataRan,temp)
}
colnames(dataRan) <- c('X1','score','Learner')
dataRan[dataRan$Learner == 'Random Forest',]$Learner <- 'RF'
dataRan[dataRan$Learner == 'Naive Bayes',]$Learner <- 'NB'

ranP <- ggplot(dataRan, aes(x=Learner, y=score, fill=Learner)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=8,
               outlier.size=2,alpha = 0.5,notch = TRUE) + 
  geom_jitter(shape=16, position=position_jitter(0.2),aes(color=Learner)) +
  ylab('Accuracy') +
  xlab('Learner') + ylim(0.0,1.0) 
ranP

dataRes <- read_csv('Holden/Analysis-Scripts/Generic-Analysis/resample-cna-50-ff/resample-cna-results-ff-1.csv')
for(i in seq(2,50)){
  temp <- read_csv(paste('Holden/Analysis-Scripts/Generic-Analysis/resample-cna-50-ff/resample-cna-results-ff-',i,'.csv',sep=''))
  dataRes <- bind_rows(dataRes,temp)
}
colnames(dataRes) <- c('X1','score','Learner')
dataRes[dataRes$Learner == 'Random Forest',]$Learner <- 'RF'
dataRes[dataRes$Learner == 'Naive Bayes',]$Learner <- 'NB'

resP <- ggplot(dataRes, aes(x=Learner, y=score, fill=Learner)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=8,
               outlier.size=2,alpha = 0.5,notch = TRUE) + 
  geom_jitter(shape=16, position=position_jitter(0.2),aes(color=Learner)) +
  ylab('Accuracy') +
  xlab('Learner') + ylim(0.0,1.0)
resP

p4 <- ggarrange(ranP,resP,impP,labels = c('A','B','C'), ncol=2,nrow=2)

ggsave(plot = p4,'Holden/Analysis-Scripts/Generic-Analysis/all-results-ff.png',width = 10, height = 7.5, units = c("in"))
