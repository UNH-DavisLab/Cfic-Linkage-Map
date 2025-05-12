# Chenopodium ficifolium linkage mapping scripts
These scripts were used in the creation of the 2025 Chenopodium ficifolium genetic linkage map.

After sequence data is received in the form of Gzipped fasta files, forward and reverse reads are placed into folders corresponding to the name of the individual sequenced. This is done because each individual will have multiple output files.

AlignAllReads.sh is invoked first to align the reads to the reference. This outputs BAM files and coverage graphs. 
Once complete, ReheaderandPileup.sh is invoked to change BAM file header information to reflect the individual name which is pulled from its containing folder. This is done in preparation for variant calling by freebayes parallel which produces a VCF file after an initial quality filter. 
This VCF file is passed to Filter.sh to remove low-quality calls and loci in preparation for conversion from VCF to a joinmap readable XLSX file type.
VCFPrepExcel.sh is used to split the input VCF into pseudochromosomes and produce one VCF containing all unassigned contigs. The file UnassignedContigs.txt is included as reference to demonstrate file formatting, with the columns being contig name, start position, and end position. We then call STACKS populations for each split VCF to convert to a Joinmap readable file type. matchSTACKSloci.py is used to add positional information to the output files created by STACKS populations, and ColorCodeandConvert.py converts csv files to XLSX and color codes the output. 
These excel files can then be copied into joinmap which is used to produce the final linkage map.
