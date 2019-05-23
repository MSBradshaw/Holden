library(readr)
library(ggplot2)
library(tidyr)

data <- read_csv('Holden2/Analysis-Scripts/Generic-Analysis/random-first-digits.csv')
td <- data %>% gather(Digit,Frequency,`0`:`9`)
p <- ggplot(data=td,aes(x=Digit,y=Frequency,color=labels)) + geom_point() + geom_jitter() + 
  ggtitle('Random Data Digit Preferences')
p
ggsave('Holden2/Analysis-Scripts/Generic-Analysis/cna-random-digit-preference.png',width = 10, height = 10, units = c("in"))


data <- read_csv('Holden2/Analysis-Scripts/Generic-Analysis/resampled-first-digits.csv')
td <- data %>% gather(Digit,Frequency,`0`:`9`)
p <- ggplot(data=td,aes(x=Digit,y=Frequency,color=labels)) + geom_point() + geom_jitter() + 
  ggtitle('Resampled Data Digit Preferences')
p
ggsave('Holden2/Analysis-Scripts/Generic-Analysis/cna-resampled-digit-preference.png',width = 10, height = 10, units = c("in"))


data <- read_csv('Holden2/Analysis-Scripts/Generic-Analysis/imputation-first-digits.csv')
td <- data %>% gather(Digit,Frequency,`0`:`9`)
p <- ggplot(data=td,aes(x=Digit,y=Frequency,color=labels)) + geom_point() + geom_jitter() + 
  ggtitle('Imputed Data Digit Preferences')
p
ggsave('Holden2/Analysis-Scripts/Generic-Analysis/cna-imputaion-digit-preference.png',width = 10, height = 10, units = c("in"))
