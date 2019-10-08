echo $1
for i in {1..100}
do
	python Classification-Downsample-Features.py ../../Data/Imputation-Data-Set/CNA-imputation-train.csv ../../Data/Imputation-Data-Set/CNA-imputation-test.csv results.csv Imputed $1
done
