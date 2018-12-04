library(readr)
library(ggplot2)

results <- read_csv('Analysis-Scripts/Distribution-Analysis/normal-and-filtered-results.csv')

#plot just normal
plot <- ggplot(results[(results$dataset=='normal'),], aes(algorithm,score)) + geom_bar(stat = 'identity') +
  ggtitle('Algorithm Accuracy On Normal Dataset')
plot
ggsave('Analysis-Scripts/Distribution-Analysis/normal-accuracies.png',plot)

#plot just filtered
plot <- ggplot(results[(results$dataset=='filtered'),], aes(algorithm,score)) + geom_bar(stat = 'identity') +
  ggtitle('Algorithm Accuracy On Filtered Dataset')
plot
ggsave('Analysis-Scripts/Distribution-Analysis/filtered-accuracies.png',plot)

#plot both
plot <- ggplot(results,aes(x=algorithm,y=score,fill=factor(dataset)))+
  geom_bar(stat="identity",position="dodge")+
  scale_fill_discrete(name="Dataset",
                      breaks=c('normal', 'filtered'),
                      labels=c('Normal', 'Filtered'))+
  xlab("Algorithm")+ylab("Accuracy")+
  ggtitle('Algorithm Accuracy on Normal and Filtered Distribution Datasets')
plot
ggsave('Analysis-Scripts/Distribution-Analysis/result-accuracies.png',plot)
