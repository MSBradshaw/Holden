library(readr)
library(tibble)
library(ggplot2)
library(dplyr)

#read in resampling data
data <- read_csv('Holden/Analysis-Scripts/Generic-Analysis/random-cna-results/random-cna-results-1.csv')
for(i in seq(2:100)){
  temp <- read_csv(paste('Holden/Analysis-Scripts/Generic-Analysis/random-cna-results/random-cna-results-',i,'.csv',sep=''))
  data <- bind_rows(data,temp)
}

#read in resampling data
for(i in seq(1:100)){
  temp <- read_csv(paste('Holden/Analysis-Scripts/Generic-Analysis/random-trans-results/random-trans-results-',i,'.csv',sep=''))
  temp$type <- c('trans','trans','trans','trans','trans','trans')
  data <- bind_rows(data,temp)
}

for(i in seq(1:100)){
  temp <- read_csv(paste('Holden/Analysis-Scripts/Generic-Analysis/random-pro-results/random-cna-results-',i,'.csv',sep=''))
  data <- bind_rows(data,temp)
}

colnames(data) <- c("X1","score","Models","type")
#remove the MLP and SVC from the results because they are crappy
datatemp = data[data$Models != 'MLP',]
datatemp = datatemp[datatemp$Models != 'SVC',]
p <- ggplot(datatemp, aes(x=type, y=score, fill=Models, color=Models)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=8,
               outlier.size=2,alpha = 0.5,notch = TRUE) + 
  ggtitle('Random Results') + 
  ylab('Accuracy') +
  xlab('Learner') + ylim(0.0,1.0) +
  scale_x_discrete(c('Data Sets','f','d'),waiver(),c('CNA','Proteomic','Transcriptomics'),c('cna','pro','trans'))
p
ggsave('Holden/Analysis-Scripts/Generic-Analysis/total-random-box-plots.png',width = 15, height = 10, units = c("in"))
