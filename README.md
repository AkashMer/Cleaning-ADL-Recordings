# Repository for Cleaning Activities of Daily Leaving(ADL) Recordings from a smartphone

This repository is for the Assignment in the Getting and Cleaning Data Course

Directories and files included in this repository

**README.md :** Details on each file and directory in this repository

**VariableMeans.txt :** Tidy data set with the average of each variable for each activity and each subject

This is obtained by running the following code on the output of `run_analysis()`,

`write.table(Name of the R object used to store output of the above mentioned function, "VariableMeans.txt", row.names = FALSE)`

And can be retrieved into R by using the following code,

`VariableMeans <- read.table("VariableMeans.txt", header = TRUE)`

**CodeBook.md :** Code Book describing the process of cleaning the raw data based on the specifications and provides description of variables in the tidy data set - `VariableMeans.txt`

**run_analysis.R :** Rscript which defines a function `run_analysis()`, which downloads the required raw data, loads in the required packages and performs the cleaning of the raw data and returns the tidy data set which should be stored in an R object

This R script was written in

```         
"R version 4.3.0 (2023-04-21 ucrt)"
```

## Reference

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
