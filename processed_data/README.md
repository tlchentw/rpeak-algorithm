# Processed Data

This folder contains **example processed feature files** used by the detection stage.  
Each record normally includes:
- `detrend_<record>.csv` : detrended ECG signal after baseline removal,  
- `code_<record>.csv` : slope-based feature values,  
- `R_<record>.csv` : reference R-peak annotations (used for evaluation).

---

## Example Files

Only one record (**203**) is included in this repository as a demonstration:
```
processed_data/
├─ detrend_203.csv
├─ code_203.csv
├─ R_203.csv
```

These files illustrate the expected format produced by `preprocessing/preprocess.m`.  
They are sufficient for running the example detection script in `detection/detection.m`.

---

## File Format

All files are saved as comma-separated values (CSV) with one numerical column per signal.  
- `detrend_*.csv` and `code_*.csv` contain continuous feature signals.  
- `R_*.csv` contains the sample indices (or times) of labelled R-peaks.

---

## Reproducing the Full Processed Dataset

To regenerate all processed data for the 48 MIT-BIH records:

1. Download the MIT-BIH Arrhythmia Database into `data/` (see `data/README.md`).
2. Run the preprocessing script:
   ```matlab
   cd preprocessing
   preprocess
   ```
3. The outputs (detrend_*.csv, code_*.csv, R_*.csv) for all records will be written to this folder.

## Notes
-	Only example data for record 203 are provided to illustrate data formats.
-	The full processed dataset can be reproduced using the provided preprocessing scripts and PhysioNet data.
-	No raw ECG data are included in this repository.
