library(readr)
library(tibble)
library(ggplot2)
library(dplyr)

#read in resampling data
data <- read_csv('Holden/Analysis-Scripts/Generic-Analysis/random-cna-results/random-cna-results-1.csv')
for(i in seq(2:50)){
  temp <- read_csv(paste('Holden/Analysis-Scripts/Generic-Analysis/random-cna-results/random-cna-results-',i,'.csv',sep=''))
  data <- bind_rows(data,temp)
}


datatemp = data[data$learner != 'MLP',]
datatemp = datatemp[datatemp$learner != 'SVC',]

p <- ggplot(datatemp, aes(x=learner, y=score, fill=learner)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=8,
               outlier.size=2,alpha = 0.5,notch = TRUE) + 
  geom_jitter(shape=16, position=position_jitter(0.2),aes(color=learner)) +
  ggtitle('Random CNA Results') + 
  ylab('Accuracy') +
  xlab('Learner') + ylim(0.0,1.0)
p
ggsave('Holden/Analysis-Scripts/Generic-Analysis/cna-random-box-plots.png',width = 10, height = 10, units = c("in"))

sd(data[data$learner=='Random Forest',]$score)
#GBC
sd(data[data$learner=='GBC',]$score)
#Naive Bayes
sd(data[data$learner=='Naive Bayes',]$score)
#KNN
sd(data[data$learner=='KNN',]$score)

