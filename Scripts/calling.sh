#!/bin/bash

#SBATCH --job-name=variant_calling_gatk
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --time=24:00:00
#SBATCH --mem=32G

# Load modules
module load GATK

# Define variables
REF_GENOME="path/to/reference/genome.fa"
OUT_DIR="path/to/output/directory"
SAMPLE_NAME="sample_name"

# Variant calling with GATK HaplotypeCaller
gatk HaplotypeCaller -R $REF_GENOME -I $OUT_DIR/${SAMPLE_NAME}_dedup.bam -O $OUT_DIR/${SAMPLE_NAME}_variants.vcf

echo "Variant calling step completed successfully."