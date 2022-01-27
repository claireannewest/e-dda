# Electron Beam Driven Discrete Dipole Approximation

The following code is a modified verison of Draine's Discrete Dipole Approximation (DDA) code version 7.1. We have modified the code to to allow for an electron beam excitation source. The following code computes the electron energy loss spectroscopy (EELS) and angle-resolved cathodoluminescence (CL) for both aloof and internal geometries. 

## Instructions
### Installation 
* Delete all executables within source_code by typeing "make clean; make veryclean"
* Compile the fortran code my typing "make all"
* Running this code works nearly the same as DDA 7.1, however the input file, "ddscat.par" now has two new lines indicating the electron beam position and velocity
* See the folder `useful_scripts` in order to run spectra and spectrum images on the cluster.

### Scripts to Run on Calculations on a Cluster
#### Make an EEL spectrum, `useful_scripts/make_spectrum`
This folder contains scripts to launch an EEL spectrum (on ESC cluster).
* Replace `shape.dat` file, update `ddscat.par` L9-L11, L15-L16, and L26.
* Update `make_dirs.py` L7-L11 to reflect your desired energy range, number of points, and points per jobs.
* Launch `submit_together.slurm`.
* When all jobs finish, run `collect_cross_secs.sh` (this is made in `make_dirs.py`.

#### Make spectrum images 
This folder will launch many scattering calculations to form a 2-D spectrum image by raster scanning the electron beam.
* Replace `shape.dat` file, update `ddscat.par` L9, L11, L15-L16, L24, and L26. DO NOT change the electron beam position. L10 should always read: ` 0.0 0.0 0.0 ` exactly.
* Define the extent of the window and the raster step size in `create_folders.slurm`, L11.
** `extent` extends the raster window beyond the shape points in each direction in the given number of dipole spacings.
** `raster_ss` sets the y and z raster step size. 
* Once both variables are updated, run `create_folders.slurm`. This will create the listed number of folders; one folder for each e-beam raster point calculation. It will also make the launch scripts. Change L6 to modify batch size (default is 20 EEL calculations per job).
* Submit all the jobs by typing in command line: `bash submit_jobs.sh`
* Once all the points have finished, run `python collect_EEL.py`. This will create `spectrum_image.txt`.

## Citations
If you use e-DDA to compute EELS, cite: https://doi.org/10.1021/nn302980u.

If you use e-DDA to compute CL, additionally cite https://doi.org/10.1021/nn401161n.
