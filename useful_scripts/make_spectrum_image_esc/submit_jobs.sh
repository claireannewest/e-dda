#!/bin/bash
#SBATCH --mail-user=caw97@cam.ac.uk
#SBATCH --job-name=submit
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --output=slurm-%j.out

for file in *.slurm;
do
  sbatch $file
done
