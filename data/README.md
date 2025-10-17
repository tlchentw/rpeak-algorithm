# Raw Data (MIT-BIH Arrhythmia Database)

This folder is reserved for the **raw ECG records** used in preprocessing.  
We do **not** distribute the MIT-BIH Arrhythmia Database itself due to PhysioNet's data policy.

To reproduce the full results, please follow the steps below.

---

## 1. Download the MIT-BIH Arrhythmia Database

Go to PhysioNet:  
https://physionet.org/content/mitdb/1.0.0/

Download all `.dat` and `.hea` files into this folder, for example:

```
data/
 ├─ 100.dat
 ├─ 100.hea
 ├─ 101.dat
 ├─ 101.hea
 ...
```

---

## 2. Read the data in MATLAB

Once the data are placed here, you can use the helper function  
`preprocessing/read_mitdb_record.m` to load them in MATLAB:

```matlab
[signal, fs] = read_mitdb_record('100', 'data');
```

This function uses the WFDB Toolbox for MATLAB
(https://physionet.org/physiotools/matlab/wfdb-app-matlab/).

⸻

License and Citation

The MIT-BIH Arrhythmia Database is distributed by PhysioNet under the
Open Data Commons Attribution License (ODC-By 1.0).
Please cite PhysioNet if you use the dataset.
