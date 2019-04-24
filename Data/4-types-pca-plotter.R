library(readr)
library(ggplot2)
library(dplyr)
library(tibble)

ran <- read_csv('Holden/Data/Random-Data-Set/train_cna_random.csv')
res <- read_csv('Holden/Data/Distribution-Data-Set/test_cna_distribution.csv')
imp <- read_csv('Holden/Data/Imputation-Data-Set/CNA-imputation-test.csv')

names <- colnames(imp)
names[length(names)] <- 'labels'
colnames(imp) <- names

comb <- bind_rows(ran,res[res$labels!='real',],imp[imp$labels!='real',])

no_labs <- comb[,1:(ncol(comb)-1)]
no_labs[is.na(no_labs)] <- 0
pca <- prcomp(no_labs)
tib <- as.tibble(pca$x)
tib$data_type <- c(replicate(50, "real"), replicate(25, "random"), replicate(25, "resampled"), replicate(25, "imputation"))

eigs <- pca$sdev^2
pc1 <- eigs[1] / sum(eigs)
pc2 <- eigs[2] / sum(eigs)

p <- ggplot(data = tib, aes(x =PC1,y=PC2,color=data_type )) + geom_point(size = 3) + 
  xlab(paste('PC1: ',pc1*100,'%')) + 
  ylab(paste('PC2: ',pc2*100,'%')) + 
  ggtitle('PCA of Real and Fake Data') + 
  theme_grey(base_size = 22)
p
ggsave('Holden/Data/pca-4-groups.png',width = 10, height = 10, units = c("in"))



