#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=72
#SBATCH --mem=64G
#SBATCH --job-name=turbogliph
#SBATCH --time=72:00:00
#SBATCH --partition=general
#SBATCH --account=a_kelvin_tuong
#SBATCH -o run_PHS002504.output
#SBATCH -e run_PHS002504.error

srun /scratch/user/uqachoo1/envs/R/bin/Rscript run_turbogliph.r /scratch/project/tcr_ml/TRUST4output_v2/PHS002504 /scratch/project/tcr_ml/GLIPH2_output/CCDI/v2/PHS002504
