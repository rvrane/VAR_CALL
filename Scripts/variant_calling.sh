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
REF_GENOME="/path/to/reference/genome.fa"
FASTQ1="/path/to/sample_R1.fastq.gz"
FASTQ2="/path/to/sample_R2.fastq.gz"
BWA_INDEX="/path/to/bwa/index"
OUT_DIR="/path/to/output/directory"
SAMPLE_NAME="sample_name"

# Check if input files exist
if [ ! -f "$REF_GENOME" ]; then
    echo "Error: Reference genome file not found"
    exit 1
fi
if [ ! -f "$FASTQ1" ]; then
    echo "Error: FASTQ file 1 not found"
    exit 1
fi
if [ ! -f "$FASTQ2" ]; then
    echo "Error: FASTQ file 2 not found"
    exit 1
fi

# Create output directory if it does not exist
if [ ! -d "$OUT_DIR" ]; then
    mkdir -p "$OUT_DIR" || { echo "Error: Unable to create output directory"; exit 1; }
fi

# Check if output file already exists
if [ -f "$OUT_DIR/${SAMPLE_NAME}.sam" ]; then
    echo "Error: Output file already exists"
    exit 1
fi

# Align reads to the reference genome with BWA
bwa mem -t 4 "$BWA_INDEX" "$FASTQ1" "$FASTQ2" > "$OUT_DIR/${SAMPLE_NAME}.sam" || { echo "Error: BWA alignment failed"; exit 1; }

# Check for BWA warnings
if [ -s "$OUT_DIR/${SAMPLE_NAME}.sam" ]; then
    echo "Warning: BWA produced warnings"
fi

echo "Alignment step completed successfully."