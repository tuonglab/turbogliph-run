#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=64G
#SBATCH --job-name=turbogliph
#SBATCH --time=72:00:00
#SBATCH --partition=general
#SBATCH --account=a_kelvin_tuong
#SBATCH -o run_PICA.output
#SBATCH -e run_PICA.error

srun /scratch/user/uqachoo1/envs/R/bin/Rscript run_turbogliph.r /QRISdata/Q7250/dandelion_tcrs/demultiplexed_clonal_frequencies/20240530_WGS_20240530_sc_PICA0001-PICA0007_PMID_97-101 /scratch/project/tcr_ml/GLIPH2_PICA/20240530_WGS_20240530_sc_PICA0001-PICA0007_PMID_97-101
