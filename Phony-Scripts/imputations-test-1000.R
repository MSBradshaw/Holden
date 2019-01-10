library(readr)
library(tibble)
library(ggplot2)
library(pamr)
library(missForest)
library(glmnet)
library(DreamAI)
set.seed(0)

#setwd('C:/Users/Michael/Documents/Holden')

args <- commandArgs(trailingOnly=TRUE)
#args[1] <- 'Data/Data-Uncompressed-Original/CNA.cct'
#args[2] <- '1'
#args 1 will be an input file
#args 2 will be the index of the row that needs to be duplicated

info <- read_tsv(args[1])
#get the protein names
names <- unlist(info['idx'])
#remove the row names
info <- info[,2:ncol(info)]
#transpose the data
info <- as.tibble(t(info))

#create person
create.person <- function(data,index){
  #create a new row which is a copy of row indicated by the index
  data[(nrow(data)+1),] <- data[index,]
  #impute 100 at a time
  #seq(1,(ncol(data)/100))
  data[nrow(data),1:(1+1000)] <- NA
  DreamAI(data)
  write_csv(data,args[3])
}

create.person(info,as.numeric(args[2]))






