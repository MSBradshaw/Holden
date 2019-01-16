library(readr)
library(tibble)
library(ggplot2)
library(pamr)
library(missForest)
library(glmnet)
library(DreamAI)
library(stringr)

set.seed(0)
args = commandArgs(trailingOnly=TRUE)

setwd('C:/Users/Michael/Documents/Holden2')
file_path = 'Data/Data-Uncompressed-Original/CNA.cct'

#file_path = args[1]
#index = as.numeric(args[2])
#start_pos = as.numeric(args[3])

file_path = 'Data/Data-Uncompressed-Original/CNA.cct'


info <- read_tsv(file_path)
#get the protein names
names <- unlist(info['idx'])
#remove the row names
info <- info[,2:ncol(info)]
#transpose the data
info <- as.tibble(t(info))

index = 1
start_pos = (ncol(info)-50)

#create person
create.person <- function(data,row,start,output_name){
  #create a new row which is a copy of row indicated by the index
  data[(nrow(data)+1),] <- data[row,]
  #impute 100 at a time
  #seq(1,(ncol(data)/100))
  print(-1)
  if(start + 100 > ncol(data)) {
    end = ncol(data)
  }else{
    end = start + 100
  }
  data[nrow(data),start:end] <- 7
  #DreamAI(data)
  print(0)
  data_small <- data[nrow(data),]
  #replace everything before start
  print(1)
  if(start != 1){
    data_small[1,start:1]  <- NA
  }
  print(2)
  #replace everything after start
  if(end < ncol(data_small) ){
    data_small[1,end:ncol(data_small)]  <- NA
  }
  print(3)
  data_small['row'] <- c(index)
  print(4)
  write_csv(data_small,output_name)
  print(5)
  return(data_small)
}


data_set = gsub('\\.\\w+','',str_extract(file_path,'\\w*\\.\\w+'))
outfile = paste(as.character(index),'-',as.character(start_pos),'-',as.character(data_set),'.csv',sep='')
a= create.person(info,index,start_pos,outfile)
