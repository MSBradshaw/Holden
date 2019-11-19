library(ggplot2)

simulate_fishers <- function(n,figure=TRUE){
  d <- data.frame(a=c(n,n),b=c(n,n))
  nums = c(0)
  p_values  =c(fisher.test(d)$p.value)
  n2 <- n * 2
  changes_at_significance = -1
  for( i in seq(1,n2)){
    #move 1
    if( i %% 2 == 0){
      #move false negative to true positive
      d[1,1] = d[1,1] + 1
      d[1,2] = d[1,2] - 1
    }else{
      #move false postiive to true negative
      d[2,2] = d[2,2] + 1
      d[2,1] = d[2,1] - 1
    }
    fisher = fisher.test(d)$p.value
    if(fisher <= 0.05 & changes_at_significance == -1){
      changes_at_significance = i
    }
    p_values <- append(fisher,p_values)
  }
  p_values <- rev(p_values)
  nums = seq(0,n2)
  
  results = data.frame(Changes=nums,P.Value=p_values)
  
  p <- ggplot(data=results,aes(x=Changes,y=P.Value)) + geom_line() + 
    scale_y_reverse( lim=c(1.00,0.00)) + 
    geom_hline(yintercept=0.05, linetype="dashed", color = "red") + 
    ggtitle(paste('Fisher\'s Exact Test (Size = ',(n*4),')')) + 
    theme(text = element_text(size=20)) 
  if(figure){
    ggsave(paste('fisherExact_',(n*4),'.png',sep=''),p) 
  }
  return(changes_at_significance)
}

simulate_fishers(4)
simulate_fishers(8)
simulate_fishers(16)
simulate_fishers(32)
simulate_fishers(64)
simulate_fishers(128)

changes_at_sig = c()
for(i in seq(4,128)){
  r = simulate_fishers(i,FALSE)
  changes_at_sig = append(r,changes_at_sig)
}
changes_at_sig <- rev(changes_at_sig)
d <- data.frame(Size=(seq(4:128)*4),Changes_to_significance=changes_at_sig)

d$Ratio <- d$Changes_to_significance / d$Size

ggplot(data=d,aes(x=Size,y=Changes_to_significance)) + geom_point() + geom_line() + ylab('Changes Required for Significance') + 
  ggtitle('Fisher\'s Exact Test')
ggsave('Fisher_Changes_vs_Size.png')
ggplot(data=d,aes(x=Size,y=Ratio)) + geom_point() + geom_line() + ylab('Ratio: Changes Required for Significance / Size')+ 
  ggtitle('Fisher\'s Exact Test')
ggsave('Fisher_Ratio_vs_Size.png')
















