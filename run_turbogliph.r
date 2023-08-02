#!/usr/bin/env Rscript

library("turboGliph")
library("parallel")
# TODO: specify directory option
setwd("/scratch/user/uqachoo1/phs002504-trust4")

files <- list.files(pattern = "airr_extracted\\.tsv", recursive = TRUE)


# Define a function to read a single file
read_file <- function(file) {
    # Read the file into a data frame
    df <- read.csv(file, sep = "\t")

    # Return the data frame
    return(df)
}
list_of_data_frames <- lapply(files, read_file)

cl <- makeCluster(8)

clusterExport(cl, "list_of_data_frames")


# Define a function to process a single data frame
process_data_frame <- function(df) {
    # Process the data frame
    # Rename the columns of the data frame
    colnames(df)[colnames(df) == "junction_aa"] <- "CDR3b"
    colnames(df)[colnames(df) == "v_call"] <- "TRBV"
    colnames(df)[colnames(df) == "j_call"] <- "TRBJ"

    # TODO: run gliph2 here
    # TODO: specify output directory for result files
    print(df)
}

# Apply the function to each data frame in parallel
parLapply(cl, list_of_data_frames, process_data_frame)

# Stop the cluster
stopCluster(cl)




# gliph2(df, n_cores = NULL, global_vgene = TRUE, result_folder = "/home/uqachoo1/gliph2output", motif_length = c(3, 4, 5, 6), min_seq_length = 8)
