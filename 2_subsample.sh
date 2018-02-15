source ~/.bashrc
source activate qiime1

mkdir -p ${outdir}/subsampletasks

counter=0

for file in ${outdir}/strict_quality_filtered/*/reads_maxee01_minlen100.fasta; do

folderpath=${file%/*}
sampleid=${folderpath##*/}
nseqs=$(( $(wc -l $file | cut -f1 -d ' ') / 2 ))
proportion=$(bc <<< "scale=5; 21000/$nseqs")

((counter++))

cat << EOF > ${outdir}/subsampletasks/task_${counter}.sh
subsample_fasta.py -i $file -o ${outdir}/subsampled/$sampleid/reads_maxee01_minlen100_subsampled.fna -p $proportion
filter_fasta.py -f ${outdir}/strict_quality_filtered/$sampleid/reads_maxee01_minlen100.fastq -o ${outdir}/subsampled/$sampleid/reads_maxee01_minlen100_subsampled.fastq -a ${outdir}/subsampled/$sampleid/reads_maxee01_minlen100_subsampled.fna
EOF

done

#SGE_Batch -c bash ${outdir}/subsampletasks/task_${SGE_TASK_ID}.sh’ -t 1-$counter -b 4 -q micro