#!/bin/bash

#SBATCH --job-name=align_bwa
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --time=12:00:00
#SBATCH --mem=32G

# Load modules
module load BWA

# Define variables
REF_GENOME="path/to/reference/genome.fa"
FASTQ1="path/to/sample_R1.fastq.gz"
FASTQ2="path/to/sample_R2.fastq.gz"
BWA_INDEX="path/to/bwa/index"
OUT_DIR="path/to/output/directory"
SAMPLE_NAME="sample_name"

# Align reads to the reference genome with BWA
bwa mem -t 4 $BWA_INDEX $FASTQ1 $FASTQ2 > $OUT_DIR/${SAMPLE_NAME}.sam

# Check for BWA errors
if [ $? -ne 0 ]; then
    echo "BWA alignment failed. Exiting."
    exit 1
fi

echo "Alignment step completed successfully."