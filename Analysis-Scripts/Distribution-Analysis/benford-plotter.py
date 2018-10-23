import os
for i in range(0,75):
    os.system(str("python3 benford-test.py " + str(i)))
    os.system(str("python3 plot-benford.py " + str(i)))
