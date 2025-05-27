#!/usr/bin/env Rscript

library("turboGliph")

# Get the command line arguments
args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 2) {
    stop("Please specify a directory to run turbogliph on and an output directory")
}

input_base_dir <- normalizePath(args[1])
output_base_dir <- normalizePath(args[2])

# List all .tsv files recursively with full paths
files <- list.files(path = input_base_dir, pattern = "\\.tsv$", recursive = TRUE, full.names = TRUE)

# Define a function to read a single file and preserve its relative path
read_file <- function(file) {
    df <- tryCatch(read.csv(file, sep = "\t"), error = function(e) return(NULL))
    
    if (!is.null(df) && nrow(df) > 1) {
        # Store data frame and the path relative to input base directory
        rel_path <- dirname(file.path(".", sub(paste0("^", input_base_dir, "/?"), "", normalizePath(file))))
        file_name <- basename(file)
        return(list(df = df, rel_path = rel_path, file_name = file_name))
    } else {
        return(NULL)
    }
}

list_of_data_frames <- lapply(files, read_file)
list_of_data_frames <- Filter(Negate(is.null), list_of_data_frames)

process_data_frame <- function(data, output_base_dir) {
    if (is.null(data)) return(NULL)
    
    df <- data$df
    rel_path <- data$rel_path
    file_name <- data$file_name
    
    # Rename columns to match gliph2 expected format
    colnames(df)[colnames(df) == "junction_aa"] <- "CDR3b"
    colnames(df)[colnames(df) == "v_call"] <- "TRBV"
    colnames(df)[colnames(df) == "j_call"] <- "TRBJ"

    # Create output directory path
    output_dir <- file.path(output_base_dir, rel_path, tools::file_path_sans_ext(file_name))
    dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

    if (nrow(df) < 2) {
        message(paste("Skipping gliph2 for file", file_name, "as it has less than 2 rows"))
        return(NULL)
    }

    tryCatch(
        {
            gliph2(df, 
                   n_cores = NULL,
                   global_vgene = TRUE,
                   result_folder = output_dir,
                   motif_length = c(2,3,4),
                   min_seq_length = 8,
                   local_similarities = TRUE,
                   lcminp = 0.05,
                   ref_cluster_size = "simulated",
                   kmer_mindepth = 2)
        },
        error = function(e) {
            message(paste("Caught an error with file", file_name, ":", e$message))
            write(paste(Sys.time(), "- Error with", file_name, ":", e$message), file = "error_log.txt", append = TRUE)

            tryCatch(
                {
                    gliph2(df, 
                           n_cores = NULL,
                           global_vgene = TRUE,
                           result_folder = output_dir,
                           motif_length = c(2,3,4),
                           min_seq_length = 8,
                           local_similarities = FALSE)
                },
                error = function(e2) {
                    message(paste("Second attempt failed for file", file_name, ":", e2$message))
                    write(paste(Sys.time(), "- Second attempt error with", file_name, ":", e2$message), file = "error_log.txt", append = TRUE)
                }
            )
        }
    )
}

# Run gliph2 on each file
lapply(list_of_data_frames, process_data_frame, output_base_dir)
