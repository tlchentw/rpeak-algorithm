function [signal, fs] = read_mitdb_record(record_name, data_dir)
%READ_MITDB_RECORD  Read MIT-BIH Arrhythmia record using WFDB tools.
%
% Usage:
%   [signal, fs] = read_mitdb_record('100', '../data');
%
% Requires:
%   The WFDB Toolbox for MATLAB (https://physionet.org/physiotools/matlab/wfdb-app-matlab/)
%
% Input:
%   record_name : Record ID (string), e.g. '100'
%   data_dir    : Path to folder containing MIT-BIH .dat and .hea files
%
% Output:
%   signal : ECG signal (column vector)
%   fs     : Sampling frequency (Hz)
%

% Check path
if nargin < 2
    data_dir = '../data';
end

% Construct full path
record_path = fullfile(data_dir, record_name);

% Read signal using WFDB toolbox
[signal, Fs, tm] = rdsamp(record_path, 1); % read lead 1

fs = Fs; % rename for consistency
end