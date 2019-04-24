library(readr)
library(tibble)
library(ggplot2)
library(dplyr)

#read in resampling data
data <- read_csv('Holden/Analysis-Scripts/Generic-Analysis/resample-cna-50-ff/resample-cna-results-ff-1.csv')
for(i in seq(2,50)){
  temp <- read_csv(paste('Holden/Analysis-Scripts/Generic-Analysis/resample-cna-50-ff/resample-cna-results-ff-',i,'.csv',sep=''))
  data <- bind_rows(data,temp)
}

p <- ggplot(data, aes(x=learner, y=score, fill=learner)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=8,
               outlier.size=2,alpha = 0.5,notch = TRUE) + 
  geom_jitter(shape=16, position=position_jitter(0.2),aes(color=learner)) +
  ggtitle('Resample CNA Results Full Features') + 
  ylab('Accuracy') +
  xlab('Learner') + ylim(0.0,1.0)
p
ggsave('Holden/Analysis-Scripts/Generic-Analysis/cna-resample-box-plots-ff.png',width = 10, height = 10, units = c("in"))
