# VAR_CALL
# Variant Calling Pipeline

This repository contains a Bash script for a variant calling pipeline using tools such as FastQC, MultiQC, BWA, GATK, VEP, and ANNOVAR. The pipeline processes raw paired-end FASTQ files to identify variants and annotate them.

## Pipeline Overview

The variant calling pipeline consists of the following steps:

1. **Quality control with FastQC:** Performs quality control analysis on raw FASTQ files.
2. **Aggregate reports with MultiQC:** Aggregates FastQC reports into a single, comprehensive report.
3. **Align reads to the reference genome with BWA:** Aligns paired-end reads to the reference genome using BWA.
4. **Convert SAM to BAM, sort, and index with GATK:** Converts the SAM file to BAM format, sorts it, and creates an index using GATK.
5. **Mark duplicates with GATK:** Identifies and marks duplicate reads in the BAM file.
6. **Variant calling with GATK HaplotypeCaller:** Calls variants from the aligned reads using GATK.
7. **Annotate variants with VEP:** Annotates variants with VEP (Variant Effect Predictor).
8. **Further annotation with ANNOVAR (optional):** Optionally annotates variants with ANNOVAR.

## Usage

To use the pipeline, follow these steps:

1. **Set Up Environment:**
   - Ensure that the necessary tools (FastQC, MultiQC, BWA, GATK, VEP, and ANNOVAR) are installed and accessible in your environment.
   - Set the paths to the reference genome, input FASTQ files, BWA index, GATK bundle, and output directory in the script.

2. **Run the Pipeline:**
   - Execute the provided Bash script (`variant_calling.sh`) in your terminal or command prompt.
   - Monitor the progress of the pipeline and check for any error messages.

3. **Review Output:**
   - After the pipeline completes successfully, review the output files generated in the specified output directory.

## Notes

- This pipeline assumes that the required tools are installed and accessible in your environment. Adjustments may be necessary based on your specific setup.
- Modify the script and parameters as needed to adapt to different reference genomes, sample names, or analysis requirements.
- Ensure that input FASTQ files are properly formatted and that paths to all required files and directories are correctly specified.

## Author

- [Rugved Rane](https://github.com/rvrane)

## License

This project is licensed under the [MIT License](LICENSE).
