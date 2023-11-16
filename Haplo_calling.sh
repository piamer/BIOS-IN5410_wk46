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

## accept argument
FILENAME=$1

## load in modules
module load BIOS-IN5410/HT-2023

## DO SOMETHING

## Make a NEW directory called gvcf.
mkdir -p $SUBMITDIR/gvcf

## RUN HAPLOTYPE CALLER
gatk HaplotypeCaller -R Orosv1mt.fasta \
-I $FILENAME --ploidy 1 -O gvcf/$FILENAME.gvcf.gz -ERC GVCF \
2> gvcf/HaploCaller_$FILENAME.out

echo ‘$FILENAME HaplotypeCalled’


## Message that you are done with the job
echo "Finished running jobs!"
