source ~/.bashrc

source activate qiime1

parallel_pick_otus_uclust_ref.py -i /raid1/home/micro/klingesj/grace/20170104_TaraPrelim16S/otus_swarm/rep_set/chimera_filtered_rep_set.fasta -o /raid1/home/micro/klingesj/grace/20170104_TaraPrelim16S/otus_swarm/renamed -s 1.0 -r /raid1/home/micro/klingesj/labhome/local/bin/miniconda3/envs/qiime1/lib/python2.7/site-packages/qiime_default_reference/gg_13_8_otus/rep_set/97_otus.fasta -O 4