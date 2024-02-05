#!/usr/bin/env Rscript

library("turboGliph")
library("parallel")

# Get the command line arguments
args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 2) {
    stop("Please specify a directory to run turbogliph on and an output directory")
}

# Set the working directory to the specified directory
setwd(args[1])

output_dir <- args[2]

files <- list.files(pattern = "airr_extracted\\.tsv", recursive = TRUE)

# Define a function to read a single file
read_file <- function(file) {
    # Read the file into a data frame
    df <- read.csv(file, sep = "\t")

    # Check if the number of rows in the data frame is greater than 1
    if (nrow(df) > 1) {
        # Return a list containing the data frame and the file name
        return(list(df = df, file_name = basename(file)))
    } else {
        # Return a list with an empty data frame and the file name
        return(list(df = data.frame(), file_name = basename(file)))
    }
}


list_of_data_frames <- lapply(files, read_file)
list_of_data_frames <- Filter(Negate(is.null), list_of_data_frames)

cl <- makeCluster(8)

clusterExport(cl, "list_of_data_frames")
clusterExport(cl, "gliph2")

process_data_frame <- function(data, output_dir) {
    # Extract the data frame and file name from the input list
    df <- data$df
    file_name <- data$file_name

    # Process the data frame
    # Rename the columns of the data frame
    colnames(df)[colnames(df) == "junction_aa"] <- "CDR3b"
    colnames(df)[colnames(df) == "v_call"] <- "TRBV"
    colnames(df)[colnames(df) == "j_call"] <- "TRBJ"

    output_dir <- file.path(output_dir, file_name)
    gliph2(df, n_cores = NULL, global_vgene = TRUE, result_folder = output_dir, motif_length = c(3, 4, 5), min_seq_length = 8)
}

# Apply the function to each data frame in parallel
parLapply(cl, list_of_data_frames, process_data_frame, output_dir)

# Stop the cluster
stopCluster(cl)
