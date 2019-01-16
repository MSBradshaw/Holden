#input 1 should be the input file
#input 2 should be the index to duplicate
#input 3 should be the start number
#input 4 should be the end number

module load r
vals=($(seq $3 100 $4))
for i in "${vals[@]}"
do
    echo $i
    #call the imputaion.R script giving it the input file, row index to duplicate and current possition in loop
    Rscript imputation.R $1 $2 $i &
done

#tells the job to not exit untill all the parallel threads have finished
wait
