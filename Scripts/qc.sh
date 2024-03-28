#!/bin/bash

#SBATCH --job-name=fastqc_multiqc
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --time=4:00:00
#SBATCH --mem=16G

# Load modules
module load FastQC
module load MultiQC

# Define variables
FASTQ1="path/to/sample_R1.fastq.gz"
FASTQ2="path/to/sample_R2.fastq.gz"
OUT_DIR="path/to/output/directory/QC"

# Ensure output directory exists
mkdir -p $OUT_DIR

# Run FastQC
fastqc -o $OUT_DIR $FASTQ1 $FASTQ2

# Check for FastQC errors
if [ $? -ne 0 ]; then
    echo "FastQC failed. Exiting."
    exit 1
fi

# Run MultiQC
multiqc $OUT_DIR -o $OUT_DIR

# Check for MultiQC errors
if [ $? -ne 0 ]; then
    echo "MultiQC failed. Exiting."
    exit 1
fi

echo "QC step completed successfully.