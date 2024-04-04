#!/bin/bash

#SBATCH --job-name=process_reads_gatk
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --time=8:00:00
#SBATCH --mem=32G

# Load modules
module load GATK

# Define variables
OUT_DIR="path/to/output/directory"
SAMPLE_NAME="sample_name"

# Convert SAM to BAM, sort and index
gatk SortSam -I $OUT_DIR/${SAMPLE_NAME}.sam -O $OUT_DIR/${SAMPLE_NAME}_sorted.bam -SO coordinate
gatk BuildBamIndex -I $OUT_DIR/${SAMPLE_NAME}_sorted.bam

# Mark duplicates
gatk MarkDuplicates -I $OUT_DIR/${SAMPLE_NAME}_sorted.bam -O $OUT_DIR/${SAMPLE_NAME}_dedup.bam -M $OUT_DIR/${SAMPLE_NAME}_dedup_metrics.txt
gatk BuildBamIndex -I $OUT_DIR/${SAMPLE_NAME}_dedup.bam

echo "Read processing step completed successfully."