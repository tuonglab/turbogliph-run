#!/usr/bin/env Rscript

library("turboGliph")

# Read the data from the TSV file
df <- read.csv("/scratch/user/uqachoo1/phs002504-trust4/UPN1125_HM1661rna_Dx_RNAseq/TRUST_UPN1125_HM1661rna_Dx_RNAseq_R1_airr_extracted.tsv", sep = "\t")

# Rename the columns of the data frame
colnames(df)[colnames(df) == "junction_aa"] <- "CDR3b"
colnames(df)[colnames(df) == "v_call"] <- "TRBV"
colnames(df)[colnames(df) == "j_call"] <- "TRBJ"

gliph2(df, n_cores = NULL, global_vgene = TRUE, result_folder = "/home/uqachoo1/gliph2output", motif_length = c(3, 4, 5, 6), min_seq_length = 8)
