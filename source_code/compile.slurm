#!/bin/bash
#SBATCH --mail-user=caw97@cam.ac.uk
#SBATCH --job-name=compile_code
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=1G
#SBATCH --mail-type=START,FAIL,END
#SBATCH --output=slurm-%j.out 

make clean
make veryclean
wait 
make all       
