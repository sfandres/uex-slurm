#!/bin/bash

echo ""
echo "Option 1 launched"
srun -p cpu12c -N 1 -n 1 -J max_fibonacci -t 00:10:00 -o max_fibonacci.out python3 max_fibonacci.py -m 10000

echo ""
echo "Option 2 launched"
srun --partition=cpu12c --nodes=1 --ntasks=1 --job-name=max_fibonacci --time=00:10:00 --output=max_fibonacci.out python3 max_fibonacci.py -m 10000
