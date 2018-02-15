outdir=/raid1/home/micro/klingesj/labhome/grace/20170130_GCMP/unzipped
#indir=###TARA raw data directory
source ~/.bashrc

source activate qiime1

mkdir -p ${outdir}/merged/

for file in /raid1/home/micro/klingesj/grace/20170130_GCMP/unzipped/*_R1_001.fastq; do

vsearch -fastq_mergepairs ${file} -fastqout ${file}/_merged.fq --threads 5

mv ${file}/_merged.fq /raid1/home/micro/klingesj/labhome/grace/20170130_GCMP/unzipped/merged

done

mkdir -p ${outdir}/strict_quality_filtered/

for file in ${outdir}/merged/*_R1_001.fastq_merged.fq; do

filename=$(basename $file)

	#trim R1 from folder names to get Sample IDs that match mapping file
sampleid=${filename/_*/}

	## filter merged reads based on 'expected errors' and a minimum read length. QIIME's method of filtering (which would take place during split_libraries) truncates reads based on the idea that quality gradually diminishes along the read. however, this assumption isn't true for reads that have been merged. This usearch function instead determines the likelihood that each read has an error based on all the quality scores, and if that likelihood passes a certain threshold, throws out the entire read.

vsearch -fastq_filter "${file}" -fastaout ${outdir}/strict_quality_filtered/${sampleid}_reads_maxee1_minlen100.fasta -fastq_maxee 1 -fastq_minlen 100 -fastq_maxns 0 -fastq_ascii 33 -relabel ${sampleid}_

done