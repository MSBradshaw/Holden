import Classification_Utils as cu
import pandas as pd
import time
import numpy as np
import re
import sys

sys.argv[1]
sys.argv[2]
#'../../Data/Distribution-Data-Set/train_cna_distribution.csv'
#'../../Data/Distribution-Data-Set/test_cna_distribution.csv'
print(1)
df = pd.read_csv(sys.argv[1])
df_test = pd.read_csv(sys.argv[2])

def first_digit_after_decimal(data):
    original = data.copy()
    col_names = list(data.columns.values)

    # convert all numbers to strings and get just the decimal portion
    pattern = re.compile(r'-?\d\.')
    for i in range(0, len(col_names)):
        col = data[col_names[i]].tolist()
        str_col = [str(j) for j in col]
        for j in range(0, len(col)):
            str_col[j] = pattern.sub('', str_col[j])
        data[col_names[i]] = str_col

    ben_data = pd.DataFrame(columns=range(0, len(data.index)))

    # for each row
    for i in range(0, len(data.index.tolist())):
        # for each item in row
        counts = np.array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

        for j in range(0, len(data.columns)):
            # get first character
            char = data.iloc[i, j][0]
            # if it is the start of an NA name it 0
            if not char.isdigit():
                if char == '-':
                    char = data.iloc[i, j][1]
                else:
                    char = 0
            counts[int(char)] += 1
            # print(a.iloc[i,j][0])
        ben_data[i] = counts / len(data.columns.tolist())
    ben_data = ben_data.T
    ben_data.columns = ['digit_0', 'digit_1', 'digit_2', 'digit_3', 'digit_4', 'digit_5', 'digit_6', 'digit_7',
                    'digit_8', 'digit_9']
    return(ben_data)
    #return(original.join(ben_data,how='outer'))

def second_digit_after_decimal(data):
    original = data.copy()
    col_names = list(data.columns.values)

    # convert all numbers to strings and get just the decimal portion
    pattern = re.compile(r'-?\d\.')
    for i in range(0, len(col_names)):
        col = data[col_names[i]].tolist()
        str_col = [str(j) for j in col]
        for j in range(0, len(col)):
            str_col[j] = pattern.sub('', str_col[j])
        data[col_names[i]] = str_col

    ben_data = pd.DataFrame(columns=range(0, len(data.index)))

    # for each row
    for i in range(0, len(data.index.tolist())):
        # for each item in row
        counts = np.array([0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

        for j in range(0, len(data.columns)):
            # get first character
            if(len(data.iloc[i, j]) > 1):
                char = data.iloc[i, j][1]
            else:
                char = '0'
            # if it is the start of an NA name it 0
            if not char.isdigit():
                if char == '-':
                    char = data.iloc[i, j][1]
                else:
                    char = 0
            counts[int(char)] += 1
            # print(a.iloc[i,j][0])
        ben_data[i] = counts / len(data.columns.tolist())
    ben_data = ben_data.T
    ben_data.columns = ['digit_0', 'digit_1', 'digit_2', 'digit_3', 'digit_4', 'digit_5', 'digit_6', 'digit_7',
                    'digit_8', 'digit_9']
    #return (original.join(ben_data, how='outer'))
    return(ben_data)

print(2)
labels = df['labels']
df = df.drop(columns=['labels'])
labels_test = df_test['labels']
first_df = first_digit_after_decimal(df)
second_df = second_digit_after_decimal(df)

first_df_test = first_digit_after_decimal(df_test)
second_df_test = second_digit_after_decimal(df_test)

df = pd.merge(first_df, second_df, left_index=True, right_index=True)
df_test = pd.merge(first_df_test, second_df_test, left_index=True, right_index=True)
print(3)
# impute the NA with 0
df = df.fillna(0)


# impute the NA with 0
df_test = df_test.fillna(0)

df.head()
df_test.head()

NUM_SPLITS = 10 # number of train/test splits in cross validation

print('KNN')
start = time.time()
knn = cu.knn_model_crossval(df, labels, NUM_SPLITS)
end = time.time()
print("Runtime:", (end - start)/60, "minutes")

print('SVC')
start = time.time()
svc = cu.SVC_model_crossval(df, labels, NUM_SPLITS)
end = time.time()
print("Runtime:", (end - start)/60, "minutes")

print('RF')
start = time.time()
rf = cu.randomforest_model_crossval(df, labels, NUM_SPLITS)
end = time.time()
print("Runtime:", (end - start)/60, "minutes")

print('Gradient Boosting')
start = time.time()
gbc = cu.gradient_boosting_crossval(df, labels, NUM_SPLITS)
end = time.time()
print("Runtime:", (end - start)/60, "minutes")

print('Niave Bayes')
start = time.time()
gnb = cu.bayes_gaussian_model_crossval(df, labels, NUM_SPLITS)
end = time.time()
print("Runtime:", (end - start)/60, "minutes")

print('LR')
#start = time.time()
#lr = cu.logistic_regression_model_crossval(df, labels, NUM_SPLITS)
#end = time.time()
#print("Runtime:", (end - start)/60, "minutes")

print('MLP')
start = time.time()
mlp = cu.mlp_crossval(df, labels, NUM_SPLITS)
end = time.time()
print("Runtime:", (end - start)/60, "minutes")

### This is commented out so that you do not call predictinos until you are done finalizing the training sets!!!
### DO NOT RUN MORE THAN ONCE! THAT IS CHEATING MYREE!
#lr_pred = lr.predict(df_test)
#lr_result = lr.score(df_test, labels_test)

rf_pred = rf.predict(df_test)
rf_result = rf.score(df_test, labels_test)

svc_pred = svc.predict(df_test)
svc_result = svc.score(df_test, labels_test)

gbc_pred = gbc.predict(df_test)
gbc_result = gbc.score(df_test, labels_test)

gnb_pred = gnb.predict(df_test)
gnb_result = gnb.score(df_test, labels_test)

knn_pred = knn.predict(df_test)
knn_result = knn.score(df_test, labels_test)

mlp_pred = mlp.predict(df_test)
mlp_result = mlp.score(df_test, labels_test)

#print(lr_result)
#print(mnb_result)
print(rf_result)
print(svc_result)
print(gbc_result)
print(gnb_result)
print(knn_result)
print(mlp_result)
results = [rf_result,svc_result,gbc_result,gnb_result,knn_result,mlp_result]
learners = ['Random Forest','SVC','GBC','Naive Bayes','KNN','MLP']
final = pd.DataFrame({'score':results,'learner':learners})
final.head()
final.to_csv(sys.argv[3])
#plot = ggplot(aes(x='learner', weight='score'), data=final) + geom_bar() + ggtitle('Resampling Test Transcriptomics Accuracy') + xlab('Model') + ylab('Accuracy')
#plot.save(sys.argv[3])
