#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=150
#SBATCH --mem=2000G
#SBATCH --job-name=turbogliph
#SBATCH --time=72:00:00
#SBATCH --partition=general
#SBATCH --account=a_kelvin_tuong
#SBATCH -o run_all.output
#SBATCH -e run_all.error

# srun /home/uqachoo1/mambaforge/envs/R/bin/Rscript run_turbogliph_ireceptor.r /QRISdata/Q6196/case_ireceptor/fanconi-anemia /scratch/project/tcr_ml/GLIPH2_output/ireceptor/fanconi-anemia
# srun /home/uqachoo1/mambaforge/envs/R/bin/Rscript run_turbogliph_ireceptor.r /QRISdata/Q6196/case_ireceptor/combined-tcell-bcell-immunodeficiency /scratch/project/tcr_ml/GLIPH2_output/ireceptor/combined-tcell-bcell-immunodeficiency
# srun /home/uqachoo1/mambaforge/envs/R/bin/Rscript run_turbogliph_ireceptor.r /QRISdata/Q6196/case_ireceptor/congenital-amegakaryocytic-thrombocytopenia /scratch/project/tcr_ml/GLIPH2_output/ireceptor/congenital-amegakaryocytic-thrombocytopenia
# srun /home/uqachoo1/mambaforge/envs/R/bin/Rscript run_turbogliph_ireceptor.r /QRISdata/Q6196/case_ireceptor/bone-marrow-disease /scratch/project/tcr_ml/GLIPH2_output/ireceptor/bone-marrow-disease
# srun /home/uqachoo1/mambaforge/envs/R/bin/Rscript run_turbogliph_ireceptor.r /QRISdata/Q6196/case_ireceptor/chronic-granulomatous-disease /scratch/project/tcr_ml/GLIPH2_output/ireceptor/chronic-granulomatous-disease
srun /home/uqachoo1/mambaforge/envs/R/bin/Rscript run_turbogliph_ireceptor.r /QRISdata/Q6196/case_ireceptor/acute-lymphocytic-leukemia /scratch/project/tcr_ml/GLIPH2_output/ireceptor/acute-lymphocytic-leukemia
# srun /home/uqachoo1/mambaforge/envs/R/bin/Rscript run_turbogliph_ireceptor.r /QRISdata/Q6196/case_ireceptor/acute-myeloid-leukemia /scratch/project/tcr_ml/GLIPH2_output/ireceptor/acute-myeloid-leukemia
# srun /home/uqachoo1/mambaforge/envs/R/bin/Rscript run_turbogliph_ireceptor.r /QRISdata/Q6196/case_ireceptor/wiskott-aldrich-syndrome /scratch/project/tcr_ml/GLIPH2_output/ireceptor/wiskott-aldrich-syndrome
# srun /home/uqachoo1/mambaforge/envs/R/bin/Rscript run_turbogliph_ireceptor.r /QRISdata/Q6196/case_ireceptor/t1-diabetes /scratch/project/tcr_ml/GLIPH2_output/ireceptor/t1-diabetes
# srun /home/uqachoo1/mambaforge/envs/R/bin/Rscript run_turbogliph_ireceptor.r /QRISdata/Q6196/case_ireceptor/juvenile-myelomonocytic-leukemia /scratch/project/tcr_ml/GLIPH2_output/ireceptor/juvenile-myelomonocytic-leukemia

# srun /home/uqachoo1/mambaforge/envs/R/bin/Rscript run_turbogliph_ireceptor.r /QRISdata/Q6196/case_ireceptor/severe-combined-immunodeficiency /scratch/project/tcr_ml/GLIPH2_output/ireceptor/severe-combined-immunodeficiency
# srun /home/uqachoo1/mambaforge/envs/R/bin/Rscript run_turbogliph_ireceptor.r /QRISdata/Q6196/control/control_ireceptor /scratch/project/tcr_ml/GLIPH2_output/ireceptor/control
