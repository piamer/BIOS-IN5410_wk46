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

## create a gvcf.list
## this creates a text file with all the HaplotypeCalled.gvcf.gz filenames.
ls *gvcf.gz > gvcf.list

## force create and remove an empty directory (needed to prevent errors when rerunning)
mkdir -p ${FILENAME}_DB; rm -r ${FILENAME}_DB

## run GATK database import (2nd step)
gatk GenomicsDBImport -V gvcf.list \
--genomicsdb-workspace-path ${FILENAME}_DB \
--intervals NC_004029.2

## run GATK genotype GVCF (3rd step)
gatk GenotypeGVCFs -R ../Orosv1mt.fasta \
-V gendb://${FILENAME}_DB -O ${FILENAME}.vcf.gz

## Access to PCA program SMART PCA
export PATH="/projects/ec34/biosin5410/sbatch_intro/SNP_calling/script/:$PATH"/

## Run PCA program SMART PCA
Run_PCA ${FILENAME}.vcf.gz

## Message that you are done with the job
echo "Finished running jobs"
