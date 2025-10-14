clear all
close all

this_dir = fileparts(mfilename('fullpath'));
root_dir = fileparts(this_dir);
data_dir = fullfile(root_dir, 'processed_data');
records_path = fullfile(root_dir, 'RECORDS');

A=readmatrix(records_path);

for fn=1:length(A)
    file_name = sprintf('X_%d.csv', A(fn));
    file_path = fullfile(data_dir, file_name);
    X=readmatrix(file_path);
    X=X/2047*10;
    Y=diff(X);
    Z=zeros(size(X,1),4);
    for i=1:2
        pr=prctile(Y(:,i),[5 10 20 80 90 95]);
        for j=1:6
            Z(1:end-1,i)=Z(1:end-1,i)+(Y(:,i)>pr(j));
        end
    end


    W=zeros(size(X));


    for i=1:2
        for j=1:ceil(size(X,1)/10000)
            idx=max((j-1)*10000-499,1):min(j*10000+500,size(X,1));
            tmp=detrend(X(idx,i),1000);
            idx1=(j-1)*10000+1:min(j*10000,size(X,1));
            if j==1
                m1=1;
            else
                m1=501;
            end
            m2=min(j*10000,size(X,1))-(j-1)*10000;
            idx2=m1:m1+m2-1;
            W(idx1,i)=tmp(idx2);
            [fn,i,j]
            toc
        end
    end

    for i=1:2
        pr=prctile(W(:,i),[5 10 20 80 90 95]);
        for j=1:6
            Z(:,i+2)=Z(:,i+2)+(W(:,i)>pr(j));
        end
    end


    writematrix(W,sprintf('detrend_%d.csv',A(fn)))
    writematrix(Z,sprintf('code_%d.csv',A(fn)))

end