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

## References

1. **FastQC:**
   - Citation: 
     - "FastQC: A quality control tool for high throughput sequence data." 
     - Simon Andrews. 2010. 
     - [https://www.bioinformatics.babraham.ac.uk/projects/fastqc/](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
   - If you're using a specific version, you may want to include the version number in your citation.

2. **MultiQC:**
   - Citation:
     - "MultiQC: Summarize analysis results for multiple tools and samples in a single report." 
     - Philip Ewels, Måns Magnusson, Sverker Lundin, and Max Käller.
     - Bioinformatics, Volume 32, Issue 19, 1 October 2016, Pages 3047–3048.
     - [https://academic.oup.com/bioinformatics/article/32/19/3047/2196506](https://academic.oup.com/bioinformatics/article/32/19/3047/2196506)

3. **BWA (Burrows-Wheeler Aligner):**
   - Citation:
     - "Fast and accurate short read alignment with Burrows-Wheeler Transform." 
     - Heng Li and Richard Durbin.
     - Bioinformatics, Volume 25, Issue 14, 15 July 2009, Pages 1754–1760.
     - [http://bio-bwa.sourceforge.net/](http://bio-bwa.sourceforge.net/)

4. **GATK (Genome Analysis Toolkit):**
   - Citation:
     - "The Genome Analysis Toolkit: A MapReduce framework for analyzing next-generation DNA sequencing data." 
     - McKenna A, Hanna M, Banks E, et al.
     - Genome Research, Volume 20, Issue 9, September 2010, Pages 1297-1303.
     - [https://gatk.broadinstitute.org/](https://gatk.broadinstitute.org/)

5. **VEP (Variant Effect Predictor):**
   - Citation:
     - "Ensembl variant effect predictor." 
     - McLaren W, Gil L, Hunt SE, et al.
     - Bioinformatics, Volume 26, Issue 16, 15 August 2010, Pages 2069–2070.
     - [https://www.ensembl.org/info/docs/tools/vep/index.html](https://www.ensembl.org/info/docs/tools/vep/index.html)

6. **ANNOVAR:**
   - Citation:
     - "ANNOVAR: Functional annotation of genetic variants from high-throughput sequencing data." 
     - Wang K, Li M, Hakonarson H.
     - Nucleic Acids Research, Volume 38, Issue 16, 1 August 2010, Page e164.
     - [https://annovar.openbioinformatics.org/en/latest/](https://annovar.openbioinformatics.org/en/latest/)

These citations provide the necessary information to properly credit the developers and acknowledge the use of these software packages in your work. Make sure to adjust the citation format according to the style guidelines of your publication or organization if needed.
