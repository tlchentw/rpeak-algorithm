# Preprocessing

This folder contains scripts for preparing ECG signals before R-peak detection.  
The preprocessing pipeline involves loading raw data from the MIT-BIH Arrhythmia Database, obtaining the annotated R-peak positions, detrending the ECG signal, and computing slope-based features for subsequent detection.

---

## Files

| File | Description |
|------|--------------|
| **read_mitdb_record.m** | Loads raw ECG signals and sampling frequency from MIT-BIH `.dat` and `.hea` files using the WFDB Toolbox for MATLAB. This function serves as the entry point for accessing the raw data. |
| **get_R.m** | Loads the labelled R-peak annotations from the MIT-BIH records and saves them as `R_<record>.csv` files for later evaluation. |
| **preprocess.m** | Main preprocessing script. For each record, this script performs baseline detrending and slope feature extraction, saving the results into `processed_data/` as `detrend_<record>.csv` and `code_<record>.csv`. |
| **detrend.m** | Implements the detrending step using the smoothness-priors method (Tarvainen et al., 2002). Called internally by `preprocess.m`. |

---

## Usage

1. Make sure the MIT-BIH data have been downloaded into the `data/` folder (see `data/README.md`).  
2. In MATLAB, open this folder and run:

```matlab
preprocess
```

This script will:
- read record names from the ../RECORDS file,
- load each record from ../data/,
- perform detrending and slope feature extraction,
- and save the processed outputs into ../processed_data/.

## Example outputs:

```
processed_data/
 ├─ detrend_203.csv
 ├─ code_203.csv
 ├─ R_203.csv
 ...
 ```
## Dependencies
- MATLAB R2020a or later
- WFDB Toolbox for MATLAB (for reading PhysioNet data)
https://physionet.org/physiotools/matlab/wfdb-app-matlab/

⸻

## Notes
- The processed files for all 48 records can be reproduced by running preprocess.m.
- Only record 203 is included in this repository as an example.
- The WFDB Toolbox must be installed and accessible in the MATLAB path before running.
