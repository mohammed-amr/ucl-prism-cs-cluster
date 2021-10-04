#   This is the most basic QSUB file needed for this cluster.
#   Further examples can be found under /share/apps/examples
#   Most software is NOT in your PATH but under /share/apps
#
#   For further info please read http://hpc.cs.ucl.ac.uk
#   For cluster help email cluster-support@cs.ucl.ac.uk
#
#   NOTE hash dollar is a scheduler directive not a comment.

#########################FLAGS#################################

# These are flags you must include - Two memory and one runtime.
# Runtime is either seconds or hours:min:sec

# test script, so we'll ask for 1G of RAM only.
#$ -l tmem=1G

# only need 1 minute to test this script.
#$ -l h_rt=00:01:00

# no need for a GPU just yet. When you do need one, uncomment 
# these lines and ask for what you need:

# #$ -l gpu=true
# #$ -pe gpu 2

# choose your preferred shell.
#$ -S /bin/bash

# merge STDOUT and STDERROR
#$ -j y

# make sure you give it a memorable name
#$ -N mscTutorialTestScript

# output directory for STDOUT file
#$ -o ~/runLog/

#########################/FLAGS#################################

#The code you want to run now goes here.

# print hostname and data for reference.
hostname
date

# I've found that I sometimes need to include the path to conda's libraries. No harm in including it.
export LD_LIBRARY_PATH=/home/$USER/miniconda3/lib/:${LD_LIBRARY_PATH}


# optionally activate your conda env here:
conda activate base

# cd somewhere where your code is.
cd /home/$USER/code/
python mscPythonTestScript.py

# print hostname and date for reference again
hostname
date

# give time for a clean exit.
sleep 10

date
