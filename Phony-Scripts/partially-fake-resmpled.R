#THIS SCRIPT TAKES 2 COMMAND LINE ARGUMENTS
# 1: the starting index
# 2: Percent fake, how much of each sample to fake as an integer
library(readr)
library(tibble)
library(ggplot2)

make_partially_fake <- function(data,portion,filename){
  #remove the fake samples
  data <- data[data$labels != 'phony',]
  
  #randomly pick half the samples
  fake_ids <- sample(1:nrow(data),floor(nrow(data)/2),replace = FALSE)
  real_ids <- c(1:75)[!(c(1:75) %in% fake_ids)]
  for( i in fake_ids){
    #selected a number of ids based of the portion of data to be made fake
    selected_ids <- sample(1,ncol(data),floor(ncol(data)*portion))
    for(j in selected_ids){
      #select a value actually seen for that protein
      num <- sample(as.numeric(unlist(data[,j])),1,replace = TRUE)
      data[i,j] <- num
    }
  }
  #relabel the not partially fake data as phony
  data$labels[fake_ids] <- "phony"
  write_csv(data,filename)
}

#setwd('/Users/michael/Holden/')
#inputdata <- read_csv('Data/Distribution-Data-Set/CNA-100/test_cna_distribution1.csv')
i=0

args <- commandArgs(trailingOnly = TRUE)
print('args')
print(args)
num <- as.numeric(args[1])
percent_fake = as.numeric(args[2])/100
for(i in c(num:(num+10))){
  print(i)
  test_name <- paste('Data/Partially-Fake-Resampled/CNA/test_partially_resampled',i,'_fake_',percent_fake,'.csv',sep='')
  make_partially_fake(inputdata,percent_fake,test_name)
}
# these files being created as test sets will be created using originl CNA Resampled Test Data, 
# this way they can be train on an already existing training file of all fake data
















