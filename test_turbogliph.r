#!/usr/bin/env Rscript

library("turboGliph")
library("parallel")

# Specify the file
file <- "/QRISdata/Q6196/case_ireceptor/wiskott-aldrich-syndrome/ir_2023-08-16_2350_64dd60afda765/ir_2023-08-16_2350_64dd60afda765_extracted.tsv"

# Read the file into a data frame
df <- read.csv(file, sep = "\t")

# Check if the number of rows in the data frame is greater than 1
if (nrow(df) > 1) {
    # Rename the columns of the data frame
    colnames(df)[colnames(df) == "junction_aa"] <- "CDR3b"
    colnames(df)[colnames(df) == "v_call"] <- "TRBV"
    colnames(df)[colnames(df) == "j_call"] <- "TRBJ"

    output_dir <- paste0(dirname(file), "/", basename(file), "_output")
    gliph2(df, n_cores = NULL, global_vgene = TRUE, result_folder = output_dir, motif_length = c(2, 3, 4), min_seq_length = 8,local_similarities = FALSE, global_similarities = TRUE)
} else {
    print("The number of rows is less than or equal to 1")
}
