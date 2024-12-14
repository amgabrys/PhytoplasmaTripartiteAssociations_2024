#!/bin/bash
 #SBATCH --nodes=1
 #SBATCH --time=40:00:00
 #SBATCH --mem=100gb
 #SBATCH --account=open

PATHS=/storage/home/ajg6826/Summer2024/plant_identification_blast
outdir=$PATHS/Sequences
originaltable=/storage/home/ajg6826/Summer2024/plant_identification_blast/plant_gene_identification_20230303_modAva.csv


cd /storage/home/ajg6826/Summer2024/plant_identification_blast/taxiddatabase
while read sample
 do
 echo "Running BLASTn on $sample"
 query=$outdir/"$sample"/Sequences/"$sample"_combinedsequence.txt
 blastn -query $query -db nt -out $outdir/"$sample"/BLASTresults/"$sample"_combinedBLASTresults.txt -remote -entrez_query "Viridiplantae [kingdom]" -outfmt "6 qseqid sallseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore score saccver qcovs sscinames staxids"
done < $outdir/listofsamples-nonredundant.txt
