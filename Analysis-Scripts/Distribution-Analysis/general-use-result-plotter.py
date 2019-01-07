import sys
from ggplot import *
import pandas as pd
final = pd.read_csv(sys.argv[1])
plot = ggplot(aes(x='learner', weight='score'), data=final) + geom_bar() + ggtitle(sys.argv[3]) + xlab('Model') + ylab('Accuracy')
plot.save(sys.argv[2])
