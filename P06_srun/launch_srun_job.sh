#!/bin/bash

echo ""
echo "Option 1 launched"
srun -p kepler -N 1 -n 1 -J max_fibonacci -t 00:10:00  python3 ../max_fibonacci.py 1000000

echo ""
echo "Option 2 launched"
srun --partition=kepler --nodes=1 --ntasks=1 --job-name=max_fibonacci --time=00:10:00 python3 ../max_fibonacci.py 1000000
