import sys
from ggplot import *
import pandas as pd
final = pd.read_csv(sys.argv[1])
plot = ggplot(aes(x='learner', weight='score'), data=final) + geom_bar() + ggtitle('Resampling Test Transcriptomics Accuracy') + xlab('Model') + ylab('Accuracy')
plot.save(sys.argv[2])