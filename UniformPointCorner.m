function [W,N] = UniformPointCorner(N,M,rou)
%% Parameter Calculation 
H1 = 1;
while nchoosek(H1+M,M-1) <= N
    H1 = H1 + 1;
end

%% Corner Weight Generation
N_sparse = nchoosek(H1+M-1,M-1);
[W_sparse,~] = UniformPoint(N_sparse,M);
 
LOG = [];
for i = 1:M
    Log = W_sparse(:,i) > (1-rou);
    LOG = [LOG, Log];
end
LOG1 = sum(LOG,2);
W = W_sparse(LOG1 == 0, :);
 
%% Central Weight Generation
N_dense = nchoosek(2*H1+M-1,M-1);
[W_dense,~] = UniformPoint(N_dense,M);
for i = 1:M
    Log = W_dense(:,i) >= (1-rou);
    W = [W; W_dense(Log, :)];
end

N = size(W,1);
end
