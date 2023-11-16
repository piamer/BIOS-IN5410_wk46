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
## Copy input files to the work directory:
touch file.txt

## show where we submitted the job
echo "Where are we:" $SUBMITDIR

## Make a directory in the directory from WHERE you submitted the script
mkdir -p $SUBMITDIR/result

## Copy output files to “home”
cp file.txt $SUBMITDIR/result/

## Remove the test file in submitdir so the only copy is in results
rm file.txt

## Naptime!
sleep 90

## Display a message
echo "Made a new directory and copied file.txt there!"

## move to the work directory
cd $SCRATCH

## Message that you are done with the job
echo "Finished running jobs!”
