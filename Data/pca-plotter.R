library(readr)
library(ggplot2)
library(tibble)

data <- read_csv('Data/Imputation-Data-Set/CNA-imputation-test.csv')
names <- colnames(data)

names[(length(names))] <- 'labels'

colnames(data) <- names

labels <- as.character(data$labels)

data$labels <- NULL
data[is.na(data)] <- 0
pca <- prcomp(data)
pca$x[,1]

eigs <- pca$sdev^2
pc1 <- eigs[1] / sum(eigs)
pc2 <- eigs[2] / sum(eigs)

df <- as_tibble(pca$x)
df['labels'] <- labels
p <- ggplot(data=df, aes(x=PC1,y=PC2, color=labels)) + geom_point(size = 3) + 
  xlab(paste('PC1 ',(round(pc1,digits=4) * 100),'%')) + 
  ylab(paste('PC2 ',(round(pc2,digits=4) * 100),'%')) + 
  ggtitle('Imputation')+ 
  theme(plot.title = element_text(size=48), 
        legend.text=element_text(size=20),
        legend.title=element_text(size=20),
        axis.title.x=element_text(size=20),
        axis.title.y=element_text(size=20))
ggsave('imputation-cna-test-pca.png', device='png',width = 10, height = 10, units = c("in"))
p
#-----------------------------------------------------------------------------------------------
#random
data <- read_csv('Data/Random-Data-Set/test_cna_random.csv')
names <- colnames(data)

names[(length(names))] <- 'labels'

colnames(data) <- names

labels <- as.character(data$labels)

data$labels <- NULL
data[is.na(data)] <- 0
pca <- prcomp(data)
pca$x[,1]

eigs <- pca$sdev^2
pc1 <- eigs[1] / sum(eigs)
pc2 <- eigs[2] / sum(eigs)

df <- as_tibble(pca$x)
df['labels'] <- labels
p <- ggplot(data=df, aes(x=PC1,y=PC2, color=labels)) + geom_point(size = 3) + 
  xlab(paste('PC1 ',(round(pc1,digits=4) * 100),'%')) + 
  ylab(paste('PC2 ',(round(pc2,digits=4) * 100),'%')) + 
  ggtitle('Random Number Generator')+ 
  theme(plot.title = element_text(size=48), 
        legend.text=element_text(size=20),
        legend.title=element_text(size=20),
        axis.title.x=element_text(size=20),
        axis.title.y=element_text(size=20))
ggsave('random-cna-test-pca.png', device='png',width = 10, height = 10, units = c("in"))
p
#--------------------------------------------------------------------------------------------
#resampling with replacement
data <- read_csv('Data/Distribution-Data-Set/test_cna_distribution.csv')
names <- colnames(data)

names[(length(names))] <- 'labels'

colnames(data) <- names

labels <- as.character(data$labels)

data$labels <- NULL
data[is.na(data)] <- 0
pca <- prcomp(data)
pca$x[,1]

eigs <- pca$sdev^2
pc1 <- eigs[1] / sum(eigs)
pc2 <- eigs[2] / sum(eigs)

df <- as_tibble(pca$x)
df['labels'] <- labels
p <- ggplot(data=df, aes(x=PC1,y=PC2, color=labels)) + geom_point(size = 3) + 
  xlab(paste('PC1 ',(round(pc1,digits=4) * 100),'%')) + 
  ylab(paste('PC2 ',(round(pc2,digits=4) * 100),'%')) + 
  ggtitle('Resampling') + 
  theme(plot.title = element_text(size=48), 
        legend.text=element_text(size=20),
        legend.title=element_text(size=20),
        axis.title.x=element_text(size=20),
        axis.title.y=element_text(size=20))
ggsave('resampling-cna-test-pca.png', device='png',width = 10, height = 10, units = c("in"))
p
