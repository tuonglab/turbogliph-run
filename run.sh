#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=75G
#SBATCH --job-name=turbogliph
#SBATCH --time=100:00:00
#SBATCH --partition=general
#SBATCH --account=a_kelvin_tuong
#SBATCH -o run_PHS002529.output
#SBATCH -e run_PHS002529.error

srun /home/uqachoo1/mambaforge/envs/R/bin/Rscript run_turbogliph.r /scratch/project/tcr_ml/TRUST4output_v2/PHS002529 /scratch/project/tcr_ml/GLIPH2_output/PHS002529
