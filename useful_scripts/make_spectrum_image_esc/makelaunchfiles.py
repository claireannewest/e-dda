import numpy as np
import os.path
import string

folders = np.loadtxt('run_these_points.txt')
batch_size = 20
for i in range(0,int(len(folders)/batch_size)+1):
    yvals = folders[batch_size*i:batch_size*(i+1),0].astype(int)
    zvals = folders[batch_size*i:batch_size*(i+1),1].astype(int)
    writefile = open(str('launch')+str(i)+str('.slurm'),'w')
    writefile.write(str('#!/bin/bash') + '\n')
    writefile.write(str('#SBATCH --mail-user=caw97@cam.ac.uk') + '\n')
    writefile.write(str('#SBATCH --job-name=') + str('sp_')+str(i)+'\n')
    writefile.write(str('#SBATCH --nodes=1') + '\n')
    writefile.write(str('#SBATCH --mem-per-cpu=4G ') + '\n')
    writefile.write(str('#SBATCH --output=slurm-%j.out') + '\n' + '\n')

    writefile.write(str('module load anaconda3') + '\n')
    writefile.write(str('yarray=(')+str(yvals)[1:-1] + str(')')+'\n')
    writefile.write(str('zarray=(')+str(zvals)[1:-1] + str(')')+'\n'+'\n')
    writefile.write(str('for ((i=0;i<${#yarray[@]};++i)); do') + '\n')
    writefile.write('\t' + str('y=${yarray[i]}; z=${zarray[i]}') + '\n')
    writefile.write('\t' + str('cd y${y}_z${z}')+'\n')
    writefile.write('\t' + str('/home/caw97/source_code/e-dda/source_code/ddscat'+'\n'))
    writefile.write('\t' + str('cd ../')+'\n')
    writefile.write(str('done')+'\n')
    writefile.close()
