% Pt：文档集合中所有可能文档对的数目，设文档总数为n，则Pt=n*(n-1)/2    
% Tm：人工分类中所有可能的文档对数量    
% Ta：聚类结果中所有可能的文档数量    
% Ei：错误关联，指在聚类结果中出现，而在人工分类中没有出现的文档对数量。    
% Em：遗漏关联，指在人工分类中出现，而在聚类结果中没有出现的文档对数量    
% 聚类错误率（CE） = （错误关联 + 遗漏关联）/文档集合中所有可能的文档对数量=(Ea + Em)/Pt
% 聚类全面率（CA） =  正确关联数/人工分类中文档对的数量 = (Ta - Ei) / Tm
% 聚类准确率（CP） =  正确关联数/聚类结果中文档对的数量 = (Ta - Ei) / Ta

% x人工分类，y聚类结果,k类数量
function error = EvaluateCluster(X,Y,k)
n = size(X,1);
pt = n*(n-1)/2;

matPairTrue = zeros(n,n);%人工分类关联
matPairAuto = zeros(n,n);%自动分类关联


for i=1:k
    clusterX = find(X==i);
    for j = 1:length(clusterX)
        for m = i:length(clusterX)
            matPairTrue(j,m) = 1;
            matPairTrue(m,j) = 1;
        end
    end
end

for i=1:k
    clusterY = find(Y==i);
    for j = 1:length(clusterY)
        for m = i:length(clusterY)
            matPairAuto(j,m) = 1;
            matPairAuto(m,j) = 1;
        end
    end
end


error = 0;
for i=1:n
    for j=i:n
        if(i~=j)
            if(matPairTrue(i,j)~=matPairAuto(i,j))
                error = error+1;
            end
        end
    end
end

error = error / pt; 



end