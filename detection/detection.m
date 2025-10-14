clear all
close all

this_dir = fileparts(mfilename('fullpath'));
root_dir = fileparts(this_dir);
data_dir = fullfile(root_dir, 'processed_data');
records_path = fullfile(root_dir, 'RECORDS');

A=readmatrix(records_path);

nh=360;
L1=12;  % the length of the left part of R

L2=6;   % the length of the right part of R
L2=round(0.1/6*nh);
L1=L2*2;

n0=nh*5/6; % 300/360 second per heart beat


TB_summary=zeros(48,6);
for fn=1:48
    idx_r=[];
    idx_n=[];
    file_name = sprintf('X_%d.csv', A(fn));
    file_path = fullfile(data_dir, file_name);
    X=readmatrix(file_path);
    X=X/2047*10;
    file_name = sprintf('R_%d.csv', A(fn));
    file_path = fullfile(data_dir, file_name);
    R=readmatrix(file_path);

    Y=diff(X);
    file_name = sprintf('detrend_%d.csv', A(fn));
    file_path = fullfile(data_dir, file_name);
    W=readmatrix(file_path);
    Ws=conv(W(:,1).^2,ones(10*nh*2+1,1)/(10*nh*2+1),'valid');
    Ws=[ones(10*nh,1)*Ws(1); Ws ; ones(10*nh,1)*Ws(end)];
    W1=W(:,1)./sqrt(Ws);
    file_name = sprintf('code_%d.csv', A(fn));
    file_path = fullfile(data_dir, file_name);
    Z=readmatrix(file_path);
    Z(:,1:2)=Z(:,1:2)-3;

    N=size(X,1);
    tmp1=[-ones(L2,1)/L2;ones(L1,1)/L1];
    tmp2=conv2(Z(:,1:2),tmp1,"valid");
    Z(:,5:6)=0;
    Z(L1:end-L2,5:6)=tmp2;


    Z(2:end-1,5:6)=Z(1:end-2,5:6);
    tmp=(movmax(W1,7,'Endpoints','fill')==W1)+(movmin(W1,7,'Endpoints','fill')==W1);



    FS1=Z(:,5).*W1.*tmp;
    RD=diff(R(2:end));
    TB_summary(fn,1:3)=[A(fn),length(R),length(find(RD<50))];

    FS_sort=sort(FS1,'descend');
    [FS_max,idx_FS]=max(abs(diff(FS_sort(round(N/n0/2)+1:round(N/n0*1.5)))));
    FS1_thr=FS_sort(round((idx_FS+round(N/n0/2))*0.8));
    FS1_thr3=FS_sort(round(idx_FS+round(N/n0/2)*1.2));
    idx_r=find(FS1(:,1)>FS1_thr/2);

    idx_rd=diff(idx_r);
    idx_r(find(idx_rd<54)+1)=[];
    idx_rd=idx_rd(idx_rd>0.3*n0 & idx_rd<2*n0);
    n1=median(idx_rd);
    len=min(round(0.3*nh),round(n1/2));

    i=length(idx_r);

    while i>0
        m1=max(1,idx_r(i)-len);
        m2=min(N,idx_r(i)+len);
        tmp=m1:m2;
        FS_tmp=FS1(tmp);
        cand_list=find(FS_tmp>FS1_thr*.5);
        if length(cand_list) > 1
            [tmp1 tmp2]=sort(FS_tmp(cand_list),'descend');
            if tmp1(1) < tmp1(2)*2 & abs(cand_list(tmp2(1))-cand_list(tmp2(2)))<36*1.5
                idx_r(i)=m1-1+min(cand_list(tmp2(1:2)));
            else
                idx_r(i)=m1-1+cand_list(tmp2(1));
            end
            while i>1 && idx_r(i-1)>m1
                i=i-1;
                idx_r(i)=[];
            end
        end
        i=i-1;
    end


    more_cand=true;        
    idx_rd=diff(idx_r);
    n1=median(idx_rd);
    len=round(n1*0.8);
    idx_r=[-len+1;idx_r;N+len-1];
 

    while more_cand==true
        more_cand=false;
        idx_rd=diff(idx_r);
        n1=median(idx_rd);
        n10=min(n1,n0);
        len=round(n1*0.8);
        idx_r(1)=-len+1;
        idx_r(end)=N+len-1;

        idx_more=find(idx_rd>n1*2);
        if ~isempty(idx_more)
            for i=1:length(idx_more)
                tmp_k=idx_r(idx_more(i))+len:idx_r(idx_more(i)+1)-len;
                len1=tmp_k-idx_r(idx_more(i));
                len2=idx_r(idx_more(i)+1)-tmp_k;
                len3=idx_r(idx_more(i)+1)-idx_r(idx_more(i));
                FS1_tmp=FS1(tmp_k);
                [FS1_high, FS1_idx]=max(FS1_tmp);
                if FS1_high > FS1_thr/8
                    new_c=idx_r(idx_more(i))+len+FS1_idx-1;
                    idx_r(end+1)=new_c;
                    more_cand=true;
                end
            end
        end
        idx_r=sort(idx_r);
    end

    more_cand=true;        


    while more_cand==true
        more_cand=false;
        idx_rd=diff(idx_r);
        n1=median(idx_rd);
        len=min(round(0.3*nh),round(n1/2));
        len=round(n1/3);
        idx_r(1)=-len+1;
        idx_r(end)=N+len-1;

        idx_more=find(idx_rd>n1*1.5);
        if ~isempty(idx_more)
            for i=1:length(idx_more)
                tmp_k=idx_r(idx_more(i))+len:idx_r(idx_more(i)+1)-len;
                len1=tmp_k-idx_r(idx_more(i));
                len2=idx_r(idx_more(i)+1)-tmp_k;
                len3=idx_r(idx_more(i)+1)-idx_r(idx_more(i));
                FS1_tmp=FS1(tmp_k,1);
                [FS1_high, FS1_idx]=max(FS1_tmp);
                if FS1_high > FS1_thr/4
                    new_c=idx_r(idx_more(i))+len+FS1_idx-1;
                    idx_r(end+1)=new_c;
                    more_cand=true;
                end
            end
        end
        idx_r=sort(idx_r);        
    end    


    idx_r(end)=[];
    idx_r(1)=[];

    if fn==29
        idx_r=setdiff(idx_r,554700:590400);
    end
    TB_summary(fn,4)=length(idx_r);
    TB_summary(fn,5:6)=check_sc2(idx_r,R,36);
    fn
end

