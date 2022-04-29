#!/bin/bash
#! Name of the job:
#SBATCH -J chair-temp
#SBATCH -A RINGE-SL3-CPU
#SBATCH -p icelake
#! How many whole nodes should be allocated?
#SBATCH --nodes=1
#! How many (MPI) tasks will there be in total? (<= nodes*76)
#! The Ice Lake (icelake) nodes have 76 CPUs (cores) each and
#! 3380 MiB of memory per CPU.
#SBATCH --ntasks=1
#! How many many cores will be allocated per task? (for single core jobs always leave this at 1)
#SBATCH --cpus-per-task=1
#! Estimated runtime: hh:mm:ss (job is force-stopped after if exceeded):
#SBATCH --time=12:00:00
#! Estimated maximum memory needed (job is force-stopped if exceeded):
#! RAM is allocated in ~5980mb blocks, you are charged per block used,
#! and unused fractions of blocks will not be usable by others.
#SBATCH --mem=30000mb

python -c 'import find_points; find_points.find_raster(extent=10, raster_ss=10)'
input="run_these_points.txt"

IFS='\t' # space is set as delimiter 
wait
while IFS= read -r line
do
    y=$(echo "$line" | awk '{print $1}')
    z=$(echo "$line" | awk '{print $2}')
    mkdir y${y}_z${z}; cd y${y}_z${z}
    ln -s ../shape.dat ./
    cp ../ddscat.par ./
    sed -i 's/0.0 0.0 0.0 = x, y, z/0.0 ${y} ${z} = x, y, z/g' ddscat.par # Add '' after -i for on Mac
    cd ../
wait
done < "$input"
 
rm -r __pycache__
wait 

python makelaunchfiles.py
