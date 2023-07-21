#!/bin/bash
module load cuda/11.6.1
source /p/vast1/bhosale1/openmp-rr/env_nvidia.sh
python optimize.py -b /p/vast1/bhosale1/hecbench/benchmarks/libor-omp/libor-omp.py --record -d nvidia -t /dev/shm
kernels=$(python optimize.py -b /p/vast1/bhosale1/hecbench/benchmarks/libor-omp/libor-omp.py -prk -d nvidia --scenario BOMN | cut -d : -f 2 | grep "omp")
for kernel in ${kernels[@]}; do
    python optimize.py -b /p/vast1/bhosale1/hecbench/benchmarks/libor-omp/libor-omp.py -d nvidia -t /dev/shm --scenario BOMN --kernel $kernel> logs/${kernel}.out 2>logs/${kernel}.err
done