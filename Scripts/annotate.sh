#!/bin/bash

#SBATCH --job-name=annotate_variants
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --time=8:00:00
#SBATCH --mem=16G

# Load modules
module load VEP
module load ANNOVAR

# Define variables
OUT_DIR="path/to/output/directory"
SAMPLE_NAME="sample_name"

# Annotate variants with VEP
vep -i $OUT_DIR/${SAMPLE_NAME}_variants.vcf -o $OUT_DIR/${SAMPLE_NAME}_annotated_variants.vcf --cache --offline --species homo_sapiens --sift b --polyphen b --symbol --numbers --biotype --total_length

# Convert VCF for ANNOVAR
convert2annovar.pl -format vcf4 $OUT_DIR/${SAMPLE_NAME}_variants.vcf > $OUT_DIR/${SAMPLE_NAME}_variants.avinput

# Annotate with ANNOVAR
table_annovar.pl $OUT_DIR/${SAMPLE_NAME}_variants.avinput humandb/ -buildver hg19 -out $OUT_DIR/${SAMPLE_NAME}_annotated -remove -protocol refGene,cytoBand,exac03,avsnp147,dbnsfp30a -operation g,r,f,f,f -nastring . -csvout -polish -xref example/gene_xref.txt

echo "Variant annotation step completed successfully."