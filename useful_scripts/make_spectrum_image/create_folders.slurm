#!/bin/bash
#SBATCH --mail-user=caw97@cam.ac.uk
#SBATCH --job-name=create_files
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=4G
#SBATCH --output=slurm-%j.out

module load anaconda3

python -c 'import find_points; find_points.find_raster(extent=20, raster_ss=10)'
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
    sed -i "s/0.0 0.0 0.0 = x, y, z/0.0 ${y} ${z} = x, y, z/g" ddscat.par
    cd ../
wait
done < "$input"
 
rm -r __pycache__
wait 

python makelaunchfiles.py
