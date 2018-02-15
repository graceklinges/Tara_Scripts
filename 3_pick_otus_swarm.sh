outdir=/raid1/home/micro/klingesj/labhome/grace/20170130_GCMP/unzipped
source ~/.bashrc

source activate qiime1

multiple_split_libraries_fastq.py -i ${outdir}/subsampled -o ${outdir}/split_libraries --include_input_dir_path --remove_filepath_in_name -p /nfs1/MICRO/Thurber_Lab/ryan/20161119_TaraPrelim16S/split_libraries_params.txt

cat ${outdir}/strict_quality_filtered/*_reads_maxee1_minlen100.fasta > ${outdir}/seqs.fna

identify_chimeric_seqs.py -i ${outdir}/seqs.fna -m usearch61 -o ${outdir}/usearch_checked_chimeras/ -r /raid1/home/micro/klingesj/labhome/databases/gg_13_8_otus/rep_set/99_otus.fasta

filter_fasta.py -f ${outdir}/seqs.fna -o ${outdir}/chimera_filtered.fna -s ${outdir}/usearch_checked_chimeras/chimeras.txt -n

pick_de_novo_otus.py -i ${outdir}/chimera_filtered.fna -o ${outdir}/otus_swarm/ -p /raid1/home/micro/klingesj/grace/Tara_Scripts/swarm_otus_params.txt -aO 5