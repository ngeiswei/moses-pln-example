#!/bin/bash

# Generate random data, run MOSES on then and create a table reporting
# number of rows and best model accuracies

set -u

n_features_list=(100)
max_rows=1000

min_rows=50
step_rows=50
max_evals=1000000
n_rows_list=($(seq $min_rows $step_rows $max_rows))

# Generate gnuplot file config
cat <<EOF > experiment.gnuplot
set title 'Accuracy vs number of rows'
set style data lines
set term png
set xlabel 'Number of Rows'
set ylabel 'Accuracy'
set output 'experiment.png'
set datafile separator ','
EOF
echo "plot \\" >> experiment.gnuplot

# Run the experiments
for n_features in ${n_features_list[@]}; do
    echo "~~~ n_features = $n_features ~~~"
    
    # Create folder where to put the experiment
    folder=experiment_n_features_${n_features}_max_rows_${max_rows}
    rm -fr $folder
    mkdir $folder

    # Define csv file containing rows and MOSES accuracies
    rows_accuracies=$folder/rows_accuracies_n_features_${n_features}_max_rows_${max_rows}.csv

    # Write header
    echo "n_rows,accuracy" > $rows_accuracies

    for n_rows in ${n_rows_list[@]}; do
        echo "~~~~~~ n_rows = $n_rows/$max_rows ~~~~~~"
        dataset=$folder/dataset_${n_features}_${n_rows}.csv
    
        echo "Generate random dataset with $n_features features and $n_rows rows"
        ./generate_random_dataset.py $n_features $n_rows > $dataset

        echo "Run MOSES learning"
        result=$folder/result_${n_features}_${n_rows}.moses
        log=$folder/moses_${n_features}_${n_rows}.log
        moses -u "target" \
            -i $dataset \
            -l debug \
            -f $log \
            -j4 \
            -m$max_evals \
            --enable-fs=1 \
            --reduct-knob-building-effort=1 \
            --hc-widen-search=1 \
            --fs-target-size=3 \
            --hc-crossover-min-neighbors=10000 \
            --hc-crossover-pop-size=1000 \
            --complexity-ratio=100 \
            --fs-algo=smd \
            --fs-focus=all \
            --fs-seed=init \
            --max-candidates-per-deme=200 \
            -c1 \
            > $result

        echo "Extract accuracy"
        accuracy=$folder/accuracy_${n_features}_${n_rows}.acc
        neg_n_errors=$(cat $result | cut -d' ' -f1)
        bc_formula="1 + $neg_n_errors / $n_rows"
        accuracy=$(bc -l <<< "$bc_formula")
        echo "$n_rows,$accuracy" >> $rows_accuracies
    done

    # Happen the plotting part
    echo "     '$rows_accuracies' using 1:2 t 'num of features = $n_features' w lines, \\" >> experiment.gnuplot

done

# Add an empty line to not finish by \
echo >> experiment.gnuplot

# Plot the experiment results
gnuplot experiment.gnuplot
