# Detection

This folder contains scripts for R-peak detection and performance evaluation.  
The detection stage reads preprocessed feature files from `processed_data/` and identifies R-peaks based on the proposed scoring algorithm.

---

## Files

| File | Description |
|------|--------------|
| **detection.m** | Main detection script. Loads detrended signals and slope features, computes the integrated score, and identifies R-peaks. The detected peaks are saved as `detected_<record>.csv`. |
| **check_sc2.m** | Compares the detected R-peaks with the reference annotations (`R_<record>.csv`) and reports performance metrics such as Sensitivity (Se), Specificity (Sp), F1 score, and Detection Error Rate (DER). |

---

## Usage

1. Make sure preprocessing has been completed and the corresponding files exist under `../processed_data/`.  
   Example expected inputs:

```
processed_data/
├─ detrend_203.csv
├─ code_203.csv
├─ R_203.csv
```

2. In MATLAB, open this folder and run:
```matlab
detection
```
3. The script will:
- iterate through all 48 records listed in ../RECORDS,
-	read each record’s feature files (detrend_*.csv, code_*.csv, R_*.csv),
-	compute R-peak detection results,
-	evaluate performance by comparing detections with reference annotations, and
-	store the overall results (Sensitivity and Specificity for each record) in the table TB_summary.

## Example: Testing a Single Record

To process only a specific record (e.g., record 203),
modify the loop variable at the top of detection.m:
```
% for fn = 1:48
for fn = 27  % record 203 corresponds to index 27 in RECORDS
```
Then run:
```matlab
detection
```

## Notes
- By default, the script evaluates all 48 MIT-BIH records sequentially.
-	To test only one record, change the loop as shown above.
