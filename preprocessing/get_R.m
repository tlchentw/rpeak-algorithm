clear all
close all

this_dir = fileparts(mfilename('fullpath'));
root_dir = fileparts(this_dir);
data_dir = fullfile(root_dir, 'processed_data');
records_path = fullfile(root_dir, 'RECORDS');

A=readmatrix(records_path);


for fn=1:48
    [R, R1]=rdann(num2str(A(fn)),'atr');
    unique(R1)
    idx=find(R1=='+'|R1=='x'|R1=='"'|R1=='|'|R1=='~'|R1=='['|R1==']'|R1=='!');

    
    R(idx)=[];
    length(R)
    sc(fn)=length(R);

    writematrix(R,sprintf('R_%d.csv',A(fn)))
end