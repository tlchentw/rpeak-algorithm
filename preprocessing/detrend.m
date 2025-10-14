function Y=detrend(X,lambda)

T=length(X);
I=speye(T);
D2=spdiags(ones(T-2,1)*[1 -2 1],[0:2],T-2,T);
Y=(I-inv(I+lambda^2*D2'*D2))*X;