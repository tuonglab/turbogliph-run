#!/usr/bin/env Rscript

library("turboGliph")

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

process_data_frame <- function(data, output_dir) {
    # Check if data is NULL
    if (is.null(data)) {
        print("Received NULL data")
        return(NULL)
    }

    # Extract the data frame and file name from the input list
    df <- data$df
    file_name <- data$file_name

    # Check if df or file_name is NULL
    if (is.null(df) || is.null(file_name)) {
        print("Received NULL df or file_name")
        return(NULL)
    }

    # Process the data frame
    # Rename the columns of the data frame
    colnames(df)[colnames(df) == "junction_aa"] <- "CDR3b"
    colnames(df)[colnames(df) == "v_call"] <- "TRBV"
    colnames(df)[colnames(df) == "j_call"] <- "TRBJ"

    output_dir <- file.path(output_dir, file_name)

    # Check if the number of rows in the data frame is less than 2
    if (nrow(df) < 2) {
        print(paste("Skipping gliph2 for file", file_name, "as it has less than 2 rows"))
        return(NULL)
    }

    tryCatch(
        {
            # Try running gliph2 with the original parameters
            gliph2(df, n_cores = NULL, global_vgene = TRUE, result_folder = output_dir, motif_length = c(3, 4, 5), min_seq_length = 8)
        },
        error = function(e) {
            # If an error occurs, print the error message
            print(paste("Caught an error with file", file_name, ":", e$message))

            # Save the error message to a log file
            write(paste("Caught an error with file", file_name, ":", e$message), file = "error_log.txt", append = TRUE)

            # Then try running gliph2 with the alternative parameters
            tryCatch(
                {
                    gliph2(df, n_cores = NULL, global_vgene = TRUE, result_folder = output_dir, motif_length = c(3, 4, 5), min_seq_length = 8, local_similarities = FALSE) # Change the parameters as needed
                },
                error = function(e) {
                    # If an error occurs, print the error message
                    print(paste("Caught an error with file", file_name, "on the second attempt:", e$message))

                    # Save the error message to a log file
                    write(paste("Caught an error with file", file_name, "on the second attempt:", e$message), file = "error_log.txt", append = TRUE)
                }
            )
        }
    )
}



# Apply the function to each data frame
lapply(list_of_data_frames, process_data_frame, output_dir)
