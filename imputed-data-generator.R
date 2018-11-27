library(readr)
library(tibble)
library(ggplot2)
library(pamr)
library(missForest)
library(glmnet)
set.seed(0)

setwd('C:/Users/Michael/Documents/Holden/')

source('DreamAI/R/main.R')

#i <- iris
#t <- unlist(as.numeric(i[1,]))
#t[1:2] <- NA
#i[151,] <- t
#i <- i[,1:ncol(i)-1]
#DreamAI(i,method='KNN')
#create a test row here

cna <- read_tsv('Data/Data-Uncompressed-Original/CNA.cct')

#get the protein names
names <- unlist(cna['idx'])
#remove the row names
cna <- cna[,2:ncol(cna)]
#transpose the data
cna <- as.tibble(t(cna))

row <- unlist(as.numeric(cna[1,]))
row[1:10] <- NA
cna[101,] <- row
DreamAI(cna)