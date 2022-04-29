import numpy as np
import os
from shutil import copyfile

folders = np.loadtxt('run_these_points.txt')
num = len(folders)
copyfile('launch_temp.slurm', str('launch.slurm'))
new_launch = open(str('launch.slurm'))
lines = new_launch.readlines()
thepoints = folders
ypoints = thepoints[:,0]
zpoints = thepoints[:,1]
new_string_y = str('yarray=( ')+' '.join(repr(int(i)) for i in ypoints).replace("'", '"') + str(' )') + str('\n')
new_string_z = str('zarray=( ')+' '.join(repr(int(i)) for i in zpoints).replace("'", '"') + str(' )') + str('\n')

lines[25] = new_string_y

lines[27] = new_string_z


lines[21] = str('#SBATCH --array=0-')+str(num-1)
new_launch = open(str('launch.slurm'),"w")
new_launch.writelines(lines)
new_launch.close()
