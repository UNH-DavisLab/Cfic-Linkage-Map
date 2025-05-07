#!/bin/bash
#Strip pseudochromosomes and run stacks
#add all the names of the unassigned contigs in to the file UnassignedContigs.txt
#adding them manually would be extremely time consuming
threads=23
VCFName=F2sWithParentsfreebayes.DPGQAB.paired #unzipped file name

bgzip $VCFName.vcf
#index
tabix -p vcf $VCFName.vcf.gz

#split
bcftools view --threads $threads $VCFName.vcf.gz --regions Cf1 -o $VCFName.Cf1.vcf
bcftools view --threads $threads $VCFName.vcf.gz --regions Cf2 -o $VCFName.Cf2.vcf
bcftools view --threads $threads $VCFName.vcf.gz --regions Cf3 -o $VCFName.Cf3.vcf
bcftools view --threads $threads $VCFName.vcf.gz --regions Cf4 -o $VCFName.Cf4.vcf
bcftools view --threads $threads $VCFName.vcf.gz --regions Cf5 -o $VCFName.Cf5.vcf
bcftools view --threads $threads $VCFName.vcf.gz --regions Cf6 -o $VCFName.Cf6.vcf
bcftools view --threads $threads $VCFName.vcf.gz --regions Cf7 -o $VCFName.Cf7.vcf
bcftools view --threads $threads $VCFName.vcf.gz --regions Cf8 -o $VCFName.Cf8.vcf
bcftools view --threads $threads $VCFName.vcf.gz --regions Cf9 -o $VCFName.Cf9.vcf
bcftools view --threads $threads $VCFName.vcf.gz -R UnassignedContigs.txt -o $VCFName.UnassignedContigs.vcf

#run populations
populations -V $VCFName.Cf1.vcf -M popmap.txt -O ficifolium/V1/Linkage/ByChr --fstats --smooth --hwe -t $threads -H -r 0.8 --map-type F2 --map-format joinmap
populations -V $VCFName.Cf2.vcf -M popmap.txt -O ficifolium/V1/Linkage/ByChr --fstats --smooth --hwe -t $threads -H -r 0.8 --map-type F2 --map-format joinmap
populations -V $VCFName.Cf3.vcf -M popmap.txt -O ficifolium/V1/Linkage/ByChr --fstats --smooth --hwe -t $threads -H -r 0.8 --map-type F2 --map-format joinmap
populations -V $VCFName.Cf4.vcf -M popmap.txt -O ficifolium/V1/Linkage/ByChr --fstats --smooth --hwe -t $threads -H -r 0.8 --map-type F2 --map-format joinmap
populations -V $VCFName.Cf5.vcf -M popmap.txt -O ficifolium/V1/Linkage/ByChr --fstats --smooth --hwe -t $threads -H -r 0.8 --map-type F2 --map-format joinmap
populations -V $VCFName.Cf6.vcf -M popmap.txt -O ficifolium/V1/Linkage/ByChr --fstats --smooth --hwe -t $threads -H -r 0.8 --map-type F2 --map-format joinmap
populations -V $VCFName.Cf7.vcf -M popmap.txt -O ficifolium/V1/Linkage/ByChr --fstats --smooth --hwe -t $threads -H -r 0.8 --map-type F2 --map-format joinmap
populations -V $VCFName.Cf8.vcf -M popmap.txt -O ficifolium/V1/Linkage/ByChr --fstats --smooth --hwe -t $threads -H -r 0.8 --map-type F2 --map-format joinmap
populations -V $VCFName.Cf9.vcf -M popmap.txt -O ficifolium/V1/Linkage/ByChr --fstats --smooth --hwe -t $threads -H -r 0.8 --map-type F2 --map-format joinmap
populations -V $VCFName.UnassignedContigs.vcf -M popmap.txt -O ficifolium/V1/Linkage/ByChr --fstats --smooth --hwe -t $threads -H -r 0.8 --map-type F2 --map-format joinmap

#remove the individual names portion - keep one file for reference.
sed -i '/individual names:/,$d' $VCFName.Cf1.p.F2.joinmap.loc
sed -i '/individual names:/,$d' $VCFName.Cf2.p.F2.joinmap.loc
sed -i '/individual names:/,$d' $VCFName.Cf3.p.F2.joinmap.loc
sed -i '/individual names:/,$d' $VCFName.Cf4.p.F2.joinmap.loc
sed -i '/individual names:/,$d' $VCFName.Cf5.p.F2.joinmap.loc
sed -i '/individual names:/,$d' $VCFName.Cf6.p.F2.joinmap.loc
sed -i '/individual names:/,$d' $VCFName.Cf7.p.F2.joinmap.loc
sed -i '/individual names:/,$d' $VCFName.Cf8.p.F2.joinmap.loc
sed -i '/individual names:/,$d' $VCFName.Cf9.p.F2.joinmap.loc
sed -i '/individual names:/,$d' $VCFName.UnassignedContigs.p.F2.joinmap.loc

#add positional information
python3 tools/matchSTACKSloci.py -l $VCFName.Cf1.p.F2.joinmap.loc -s $VCFName.Cf1.p.sumstats.tsv -o FilteredJoinmapFBCf1.csv
python3 tools/matchSTACKSloci.py -l $VCFName.Cf2.p.F2.joinmap.loc -s $VCFName.Cf2.p.sumstats.tsv -o FilteredJoinmapFBCf2.csv
python3 tools/matchSTACKSloci.py -l $VCFName.Cf3.p.F2.joinmap.loc -s $VCFName.Cf3.p.sumstats.tsv -o FilteredJoinmapFBCf3.csv
python3 tools/matchSTACKSloci.py -l $VCFName.Cf4.p.F2.joinmap.loc -s $VCFName.Cf4.p.sumstats.tsv -o FilteredJoinmapFBCf4.csv
python3 tools/matchSTACKSloci.py -l $VCFName.Cf5.p.F2.joinmap.loc -s $VCFName.Cf5.p.sumstats.tsv -o FilteredJoinmapFBCf5.csv
python3 tools/matchSTACKSloci.py -l $VCFName.Cf6.p.F2.joinmap.loc -s $VCFName.Cf6.p.sumstats.tsv -o FilteredJoinmapFBCf6.csv
python3 tools/matchSTACKSloci.py -l $VCFName.Cf7.p.F2.joinmap.loc -s $VCFName.Cf7.p.sumstats.tsv -o FilteredJoinmapFBCf7.csv
python3 tools/matchSTACKSloci.py -l $VCFName.Cf8.p.F2.joinmap.loc -s $VCFName.Cf8.p.sumstats.tsv -o FilteredJoinmapFBCf8.csv
python3 tools/matchSTACKSloci.py -l $VCFName.Cf9.p.F2.joinmap.loc -s $VCFName.Cf9.p.sumstats.tsv -o FilteredJoinmapFBCf9.csv
python3 tools/matchSTACKSloci.py -l $VCFName.UnassignedContigs.p.F2.joinmap.loc -s $VCFName.UnassignedContigs.p.sumstats.tsv -o FilteredJoinmapFBUnassignedContigs.csv

#remove lines in csv containing at least x number of missing data columns
sed -i '/-,-,-,-,-,-/d' FilteredJoinmapFBCf1.csv
sed -i '/-,-,-,-,-,-/d' FilteredJoinmapFBCf2.csv
sed -i '/-,-,-,-,-,-/d' FilteredJoinmapFBCf3.csv
sed -i '/-,-,-,-,-,-/d' FilteredJoinmapFBCf4.csv
sed -i '/-,-,-,-,-,-/d' FilteredJoinmapFBCf5.csv
sed -i '/-,-,-,-,-,-/d' FilteredJoinmapFBCf6.csv
sed -i '/-,-,-,-,-,-/d' FilteredJoinmapFBCf7.csv
sed -i '/-,-,-,-,-,-/d' FilteredJoinmapFBCf8.csv
sed -i '/-,-,-,-,-,-/d' FilteredJoinmapFBCf9.csv
sed -i '/-,-,-,-,-,-/d' FilteredJoinmapFBUnassignedContigs.csv

#Convert csv to xlsx and color code the values. Use any sumstats.tsv to get the proper plant ID header information to copy into the excel files. This is done manually. 
python3 tools/ColorCodeandConvert.py -i FilteredJoinmapFBCf1
python3 tools/ColorCodeandConvert.py -i FilteredJoinmapFBCf2
python3 tools/ColorCodeandConvert.py -i FilteredJoinmapFBCf3
python3 tools/ColorCodeandConvert.py -i FilteredJoinmapFBCf4
python3 tools/ColorCodeandConvert.py -i FilteredJoinmapFBCf5
python3 tools/ColorCodeandConvert.py -i FilteredJoinmapFBCf6
python3 tools/ColorCodeandConvert.py -i FilteredJoinmapFBCf7
python3 tools/ColorCodeandConvert.py -i FilteredJoinmapFBCf8
python3 tools/ColorCodeandConvert.py -i FilteredJoinmapFBCf9
python3 tools/ColorCodeandConvert.py -i FilteredJoinmapFBUnassignedContigs