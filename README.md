## Project Overview

This repository contains a subset of data from the Future Oak project, focussing on the comparision of trees with AOD and COD, at two sites (MOCCA and STHWK). It also includes a brief analysis of alpha and beta diversity of these tree microbiomes.

## Structure
```
├── data/
│ ├── FO_16S_Phyloseq_unfiltered.rds # Processed phyloseq objects
│ ├── FO_ITS_Phyloseq_unfiltered.rds # Processed phyloseq objects
│ ├── FO_COD_bacteria_ASV_table.csv # ASV abundance matrix
│ ├── FO_COD_fungi_ASV_table.csv # ASV abundance matrix
│ ├── FO_COD_bacteria_tax_table.csv # ASV taxonomic assignment
│ ├── FO_COD_fungi_tax_table.csv # ASV taxonomic assignment
│ ├── FO_COD_bacteria_sample_table.csv # Sample metadata
│ └── FO_COD_fungi_sample_table.csv # Sample metadata
├── src/
│ └── phyloseq_summary_table.R # Custom function to print summary tables
├── 260617_COD_analysis.qmd # Quarto report with basic alpha and beta diversity analysis
├── 260617_COD_analysis.html # Report output with basic alpha and beta diversity analysis
├── renv.lock # {renv} lockfile which can be use to restore all package versions
└── README.md
```

## Requirements

- R >= 4.5
- phyloseq
- ggplot2
- dplyr / tidyverse
- purrr

Install dependencies using {renv}:

```r
install.packages("renv")
renv::restore()
```
