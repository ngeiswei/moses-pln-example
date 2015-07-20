set title 'Accuracy vs number of rows'
set style data lines
set term png
set xlabel 'Number of Rows'
set ylabel 'Accuracy'
set output 'experiment.png'
set datafile separator ','
plot \
     'experiment_n_features_100_max_rows_1000/rows_accuracies_n_features_100_max_rows_1000.csv' using 1:2 t 'num of features = 100' w lines, \

