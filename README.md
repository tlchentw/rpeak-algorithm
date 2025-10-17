# R-Peak Detection Algorithm (MIT-BIH)

A reference implementation of a two-stage **R-peak detection algorithm** for ECG signals,  
demonstrating a simple and interpretable approach evaluated on the MIT-BIH Arrhythmia Database (MITDB).

---

## Overview

This repository provides MATLAB code for reproducing the main steps of the proposed R-peak detection method:

1. **Data Preparation** — obtain raw ECG data from the MIT-BIH Arrhythmia Database.  
2. **Preprocessing** — detrend the baseline and compute slope-based features.  
3. **Detection** — identify R-peaks using an integrated scoring method and summarize the results.  
4. **Evaluation** — calculate performance metrics (Sensitivity, Specificity, F1, DER).

The implementation is modular and focuses on transparency and reproducibility.

---

## Repository Structure
```
rpeak-algorithm/
├─ data/             ← instructions for downloading MIT-BIH data (no data included)
├─ preprocessing/    ← preprocessing and feature extraction scripts
├─ detection/        ← R-peak detection and evaluation scripts
├─ processed_data/   ← example processed data for record 203
├─ RECORDS           ← list of 48 record IDs in MIT-BIH
├─ LICENSE           ← MIT License for this code
└─ README.md         ← (this file)
```

---

## Getting Started

### 1. Download the MIT-BIH Arrhythmia Database

- Visit PhysioNet:  
  https://physionet.org/content/mitdb/1.0.0/
- Place all `.dat` and `.hea` files in the `data/` folder.  
  (see `data/README.md` for detailed instructions)

---

### 2. Preprocessing

Run the preprocessing scripts to generate detrended and slope features.

```matlab
cd preprocessing
preprocess
```
This will:
-	read record names from ../RECORDS
-	load each record from ../data/
-	produce detrend_<record>.csv, code_<record>.csv, and R_<record>.csv
-	save them in ../processed_data/

Example:
```
processed_data/
 ├─ detrend_203.csv
 ├─ code_203.csv
 ├─ R_203.csv
```

3. Detection

Run the detection script to perform R-peak identification and summarize performance.
```matlab
cd detection
detection
```
The script processes all 48 records by default and stores results (Sensitivity, Specificity)
in a MATLAB variable named TB_summary.

To test a single record (e.g., record 203):
```matlab
for fn = 27   % record 203
```
## Example Data

Only one record (203) is included in processed_data/ as a demonstration.
All other records can be reproduced by running the preprocessing scripts
after downloading the MIT-BIH dataset.

⸻

## Dependencies
	•	MATLAB R2020a or later
	•	WFDB Toolbox for MATLAB (for reading PhysioNet data)
https://physionet.org/physiotools/matlab/wfdb-app-matlab/

⸻

Citation and License

## Dataset:
The MIT-BIH Arrhythmia Database is provided by PhysioNet under the
Open Data Commons Attribution License (ODC-By 1.0).
Please cite PhysioNet if you use the dataset.

## Code License:
This repository is released under the MIT License.
You are free to use and modify the code with proper attribution.
