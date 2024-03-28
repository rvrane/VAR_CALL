#!/bin/bash

#SBATCH --job-name=variant_calling
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --time=48:00:00
#SBATCH --mem=32G

# Load modules or set PATH for the tools if necessary
# module load FastQC
# module load MultiQC
# module load BWA
# module load GATK
# module load VEP
# module load ANNOVAR

# Define variables
REF_GENOME="path/to/reference/genome.fa"
FASTQ1="path/to/sample_R1.fastq.gz"
FASTQ2="path/to/sample_R2.fastq.gz"
BWA_INDEX="path/to/bwa/index"
GATK_BUNDLE="path/to/gatk/bundle"
OUT_DIR="path/to/output/directory"
SAMPLE_NAME="sample_name"

# Step 1: Quality control with FastQC
fastqc -o $OUT_DIR/QC $FASTQ1 $FASTQ2

# Step 2: Aggregate reports with MultiQC
multiqc $OUT_DIR/QC -o $OUT_DIR/QC

# Step 3: Align reads to the reference genome with BWA
bwa mem -t 4 $BWA_INDEX $FASTQ1 $FASTQ2 > $OUT_DIR/${SAMPLE_NAME}.sam

# Step 4: Convert SAM to BAM, sort and index using GATK
gatk SortSam -I $OUT_DIR/${SAMPLE_NAME}.sam -O $OUT_DIR/${SAMPLE_NAME}_sorted.bam -SO coordinate
gatk BuildBamIndex -I $OUT_DIR/${SAMPLE_NAME}_sorted.bam

# Step 5: Mark duplicates
gatk MarkDuplicates -I $OUT_DIR/${SAMPLE_NAME}_sorted.bam -O $OUT_DIR/${SAMPLE_NAME}_dedup.bam -M $OUT_DIR/${SAMPLE_NAME}_dedup_metrics.txt
gatk BuildBamIndex -I $OUT_DIR/${SAMPLE_NAME}_dedup.bam

# Step 6: Variant calling with GATK HaplotypeCaller
gatk HaplotypeCaller -R $REF_GENOME -I $OUT_DIR/${SAMPLE_NAME}_dedup.bam -O $OUT_DIR/${SAMPLE_NAME}_variants.vcf

# Step 7: Annotate variants with VEP
vep -i $OUT_DIR/${SAMPLE_NAME}_variants.vcf -o $OUT_DIR/${SAMPLE_NAME}_annotated_variants.vcf --cache --offline --species homo_sapiens --sift b --polyphen b --symbol --numbers --biotype --total_length

# Step 8: Further annotation with ANNOVAR (optional, depending on your needs)
# Convert VCF for ANNOVAR
convert2annovar.pl -format vcf4 $OUT_DIR/${SAMPLE_NAME}_variants.vcf > $OUT_DIR/${SAMPLE_NAME}_variants.avinput

# Annotate with ANNOVAR
table_annovar.pl $OUT_DIR/${SAMPLE_NAME}_variants.avinput humandb/ -buildver hg19 -out $OUT_DIR/${SAMPLE_NAME}_annotated -remove -protocol refGene,cytoBand,exac03,avsnp147,dbnsfp30a -operation g,r,f,f,f -nastring . -csvout -polish -xref example/gene_xref.txt

echo "Variant calling pipeline completed successfully."