library(readr)
library(tibble)
library(ggplot2)
library(dplyr)

#read in resampling data
data <- read_csv('Holden/Analysis-Scripts/Generic-Analysis/resample-pro-results/resample-pro-1.csv')
for(i in seq(2:100)){
  temp <- read_csv(paste('Holden/Analysis-Scripts/Generic-Analysis/resample-pro-results/resample-pro-',i,'.csv',sep=''))
  data <- bind_rows(data,temp)
}

name <- 'y_factor'
datatemp <- data
datatemp$y_factor <- factor((unlist(data$y_factor)),as.character())


p <- ggplot(data, aes(x=learner, y=score, fill=learner)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=8,
               outlier.size=2,alpha = 0.5,notch = TRUE) + 
  geom_jitter(shape=16, position=position_jitter(0.2),aes(color=learner)) +
  ggtitle('Resampling Proteomic Results') + 
  ylab('Accuracy') +
  xlab('Learner') + ylim(0.0,1.0)
p
ggsave('Holden/Analysis-Scripts/Generic-Analysis/pro-resampling-box-plots.png',width = 10, height = 10, units = c("in"))
