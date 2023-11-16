#!/bin/bash

#SBATCH --job-name=TestJob 	#give jobs a name
#SBATCH --account=ec34	 	#current project that we are on
#SBATCH --nodes=1 		#number of nodes/CPU
#SBATCH --ntasks=1 		#how many ”tasks”
#SBATCH --time=3:00:00 		#how long the job will go for
#SBATCH --mem=1G 		#how much memory

## Set up job environment
set -o errexit 			# Exit script on any error
set -o nounset 			# Treat any unset variables as an error

module --quiet purge 		# this “resets” the environment, quite useful!

## DO SOMETHING
## time to introduce arguments B)
FILENAME=$1

## Make a directory in the directory from WHERE you submitted the script
mkdir -p $SUBMITDIR/result

## what are we up to then
echo "We be in" $SUBMITDIR
echo "We be countin lines in" $FILENAME

## now go do it
wc $FILENAME > $SUBMITDIR/result/wc_$FILENAME.out

## Message that you are done with the job
echo "Finished running jobs!"
