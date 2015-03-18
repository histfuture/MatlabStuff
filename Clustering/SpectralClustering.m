%谱聚类,输入聚类矩阵X,聚类数目k
function [initC,itcount,idxbest] = SpectralClustering(X, k,isMaxMin)
W = edist(X,X);
maxMat = repmat(max(W,[],2),1,size(W,2));
W =1 - W./maxMat;%归一化
D = diag(sum(W,2));
L = D - W;
[Q, V] = eigs(L, k, 'SR');
[initC,itcount,idxbest] = Cmeans(Q, k,isMaxMin);
end