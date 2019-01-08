library(readr)
library(tibble)
library(ggplot2)
library(pamr)
library(missForest)
library(glmnet)
library(DreamAI)
set.seed(0)

setwd('C:/Users/Michael/Documents/Holden')

cna <- read_tsv('Data/Data-Uncompressed-Original/CNA.cct')
#get the protein names
names <- unlist(cna['idx'])
#remove the row names
cna <- cna[,2:ncol(cna)]
#transpose the data
cna <- as.tibble(t(cna))

#create person
create.person <- function(data,index){
  #create a new row which is a copy of row indicated by the index
  data[(nrow(data)+1),] <- data[index,]
  #impute 100 at a time
  #seq(1,(ncol(data)/100))
  for(i in seq(1,2)){
    #replace i through i + 100 with NA
    data[nrow(data),i:(i+100)] <- NA
    output <- DreamAI(data)
    print('Printing Data')
    print(data)
    print('Printing what was returned')
    print(output)
  }
}

create.person(cna,1)





