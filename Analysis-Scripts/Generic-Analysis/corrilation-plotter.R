library(readr)
library(ggplot2)
library(dplyr)
library(ggpubr)


data <- read_csv('Data/Random-Data-Set/CNA-100/test_cna_random1.csv')
data2 <- read_csv('Data/Random-Data-Set/CNA-100/train_cna_random1.csv')
data3 <- bind_rows(data,data2)

data <- read_csv('Data/Distribution-Data-Set/CNA-100/test_cna_distribution1.csv')
data2 <- read_csv('Data/Distribution-Data-Set/CNA-100/train_cna_distribution1.csv')
data4 <- bind_rows(data,data2)

data <- read_csv('Data/Imputation-Data-Set/CNA-imputation-test.csv')
data2 <- read_csv('Data/Imputation-Data-Set/CNA-imputation-train.csv')
data5 <- bind_rows(data,data2)


#perfect coorilation
spearman <- cor(data3[data3$labels == 'real',]$PLEKHN1,data3[data3$labels == 'real',]$HES4, method="spearman")
a <- ggplot(data = data3[data3$labels == 'real',], aes(x = PLEKHN1, y =HES4 )) + geom_point() + 
  ggtitle(paste('Adjacent Gene Pair, Real Data, Spearman: ', round(spearman,digits = 3),sep='')) + 
  theme(
    plot.title = element_text(size = 11),
    axis.title=element_text(size=11))
#ggsave('Analysis-Scripts/Generic-Analysis/real-perfect-coorilation.png',width = 10, height = 10, units = c("in"))

#not perfect coorilation
spearman <- cor(data3[data3$labels == 'real',]$DFFB,data3[data3$labels == 'real',]$OR4F5, method="spearman")
b <- ggplot(data = data3[data3$labels == 'real',], aes(x = DFFB, y =OR4F5 )) + geom_point() + 
  ggtitle(paste('Distant Gene Pair, Real Data, Spearman: ', round(spearman,digits = 3),sep='')) +    theme(     plot.title = element_text(size = 11),     axis.title=element_text(size=11))
#ggsave('Analysis-Scripts/Generic-Analysis/real-bad-coorilation.png',width = 10, height = 10, units = c("in"))

#perfect coorilation
spearman <- cor(data3[data3$labels == 'phony',]$PLEKHN1,data3[data3$labels == 'phony',]$HES4, method="spearman")
c <- ggplot(data = data3[data3$labels == 'phony',], aes(x = PLEKHN1, y =HES4 )) + geom_point() + 
  ggtitle(paste('Adjacent Gene Pair, Random, Spearman: ', round(spearman,digits = 3),sep='')) +    theme(     plot.title = element_text(size = 11),     axis.title=element_text(size=11))
#ggsave('Analysis-Scripts/Generic-Analysis/fake-random-perfect-coorilation.png',width = 10, height = 10, units = c("in"))

#not perfect coorilation
spearman <- cor(data3[data3$labels == 'phony',]$DFFB,data3[data3$labels == 'phony',]$OR4F5, method="spearman")
d <- ggplot(data = data3[data3$labels == 'phony',], aes(x = DFFB, y =OR4F5 )) + geom_point() + 
  ggtitle(paste('Distant Gene Pair, Random, Spearman: ', round(spearman,digits = 3),sep='')) +    theme(     plot.title = element_text(size = 11),     axis.title=element_text(size=11))
#ggsave('Analysis-Scripts/Generic-Analysis/fake-random-bad-coorilation.png',width = 10, height = 10, units = c("in"))

#perfect coorilation
spearman <- cor(data4[data4$labels == 'phony',]$PLEKHN1,data4[data4$labels == 'phony',]$HES4, method="spearman")
e <- ggplot(data = data4[data4$labels == 'phony',], aes(x = PLEKHN1, y =HES4 )) + geom_point() + 
  ggtitle(paste('Adjacent Gene Pair, Resampled, Spearman: ', round(spearman,digits = 3),sep='')) +    theme(     plot.title = element_text(size = 11),     axis.title=element_text(size=11))
#ggsave('Analysis-Scripts/Generic-Analysis/fake-resample-perfect-coorilation.png',width = 10, height = 10, units = c("in"))

#not perfect coorilation
spearman <- cor(data4[data4$labels == 'phony',]$DFFB,data4[data4$labels == 'phony',]$OR4F5, method="spearman")
f <- ggplot(data = data4[data4$labels == 'phony',], aes(x = DFFB, y =OR4F5 )) + geom_point() + 
  ggtitle(paste('Distant Gene Pair, Resampled, Spearman: ', round(spearman,digits = 3),sep='')) +    theme(     plot.title = element_text(size = 11),     axis.title=element_text(size=11))
#ggsave('Analysis-Scripts/Generic-Analysis/fake-resample-bad-coorilation.png',width = 10, height = 10, units = c("in"))

#perfect coorilation
spearman <- cor(data5[data5$X17157 == 'phony',]$PLEKHN1,data5[data5$X17157 == 'phony',]$HES4, method="spearman")
g <- ggplot(data = data5[data5$X17157 == 'phony',], aes(x = PLEKHN1, y =HES4 )) + geom_point() + 
  ggtitle(paste('Adjacent Gene Pair, Imputation, Spearman: ', round(spearman,digits = 3),sep='')) +    theme(     plot.title = element_text(size = 11),     axis.title=element_text(size=11))
#ggsave('Analysis-Scripts/Generic-Analysis/fake-imputation-perfect-coorilation.png',width = 10, height = 10, units = c("in"))

#not perfect coorilation
spearman <- cor(data5[data5$X17157 == 'phony',]$DFFA,data5[data5$X17157 == 'phony',]$OR4F5, method="spearman")
h <- ggplot(data = data5[data5$X17157 == 'phony',], aes(x = DFFB, y =OR4F5 )) + geom_point() + 
  ggtitle(paste('Distant Gene Pair, Imputation, Spearman: ', round(spearman,digits = 3),sep='')) +    theme(     plot.title = element_text(size = 11),     axis.title=element_text(size=11))
#ggsave('Analysis-Scripts/Generic-Analysis/fake-imputation-bad-coorilation.png',width = 10, height = 10, units = c("in"))

p <- ggarrange(a,b,c,d,e,f,g,h,labels = c('A','B','C','D','E','F','G','H'), ncol=2,nrow=4)
p
ggsave('Analysis-Scripts/Generic-Analysis/all-coorilation-plots.png',width=8.5,height=11, units = c('in'))
