source ~/.bashrc

source activate qiime1

### you will need to change all the directories so that the outputs are in your folder rather than mine. The input for this first command, multiple_split_libraries_fastq.py, was originally all the joined sequences. However, I've now gone and performed some super-strict quality filtering on those sequences (in 1_init.sh), and you should subsample those new ones with the script we made on Friday. Then, the input to multiple_split_libraries_fastq.py will be your new folder of quality-filtered and subsampled fastqs, instead of the folder 'joined'.

multiple_split_libraries_fastq.py -i ${outdir}/strict_quality_filtered -o ${outdir}/split_libraries_no_subsample --include_input_dir_path --remove_filepath_in_name -p /nfs1/MICRO/Thurber_Lab/ryan/20161119_TaraPrelim16S/split_libraries_params.txt

identify_chimeric_seqs.py -i ${outdir}/split_libraries_no_subsample/seqs.fna -m usearch61 -o ${outdir}/usearch_checked_chimeras_no_subsample/ -r /raid1/home/micro/klingesj/labhome/local/bin/miniconda3/envs/qiime1/lib/python2.7/site-packages/qiime_default_reference/gg_13_8_otus/rep_set/97_otus.fasta

filter_fasta.py -f ${outdir}/split_libraries_no_subsample/seqs.fna -o ${outdir}/split_libraries_no_subsample/chimera_filtered.fna -s ${outdir}/usearch_checked_chimeras_no_subsample/chimeras.txt -n


pick_open_reference_otus.py -i ${outdir}/split_libraries_no_subsample/chimera_filtered.fna -o ${outdir}/otus_open_ref_usearch_no_subsample/ -r /nfs1/MICRO/Thurber_Lab/local/bin/miniconda3/envs/qiime1/lib/python2.7/site-packages/qiime_default_reference/gg_13_8_otus/rep_set/97_otus.fasta -m usearch61 -f -p /raid1/home/micro/klingesj/grace/Tara_Scripts/otus_params.txt -aO 5