library(readr)
library(ggplot)
library(dplyr)

ran <- read_csv('Analysis-Scripts/Imputation-Analysis/random-cna-results.csv')
re <- read_csv('Analysis-Scripts/Imputation-Analysis/resampling-cna-results.csv')
imp <- read_csv('Analysis-Scripts/Imputation-Analysis/imputation-cna-results.csv')

combind <- bind_rows(ran,re,imp)

levels <- c(3,1,2)

p = ggplot(data = combind, aes(x = type, y = score, fill=learner)) + geom_bar(stat='identity', position="dodge")
p =  p + 
  xlab('Fabrication Method') + 
  ylab('Accuracy') + 
  ggtitle('Fabrication Detection Accuracy') + 
  theme(plot.title = element_text(size=48), 
        legend.text=element_text(size=20),
        legend.title=element_text(size=20),
        axis.title.x=element_text(size=20),
        axis.text.x=element_text(size=15),
        axis.text.y=element_text(size=15),
        axis.title.y=element_text(size=20))  +
  scale_x_discrete(c('Methods of Fabrication','f','d'),waiver(),c('Random','Resampling','Imputation'),c('random','resample','imputation'))
ggsave('CNA-total-fabrication-accuracy.png', device='png',width = 15, height = 10, units = c("in"))
p
