#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=72
#SBATCH --mem=64G
#SBATCH --job-name=turbogliph
#SBATCH --time=72:00:00
#SBATCH --partition=general
#SBATCH --account=a_kelvin_tuong
#SBATCH -o run_PHS003111.output
#SBATCH -e run_PHS003111.error

srun /home/uqachoo1/mambaforge/envs/R/bin/Rscript run_turbogliph.r /scratch/project/tcr_ml/TRUST4output_v2/PHS003111 /scratch/project/tcr_ml/GLIPH2_output/CCDI/PHS003111
# srun /home/uqachoo1/mambaforge/envs/R/bin/Rscript run_turbogliph.r /QRISdata/Q6196/case_ireceptor/wiskott-aldrich-syndrome /scratch/project/tcr_ml/GLIPH2_output/ireceptor/wiskott-aldrich-syndrome
