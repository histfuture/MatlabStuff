%MMD聚类，X样本矩阵，t阈值
function [centroids,idxbest] = MMD(X, t)
    k = 1;
    XBack = X;
    y = [];%centroids
    y(1,:) = X(1,:);
    dist = edist(y,X);
    k=2;
    [~,y2idx]=max(min(dist,[],1),[],2);
    y(2,:) = X(y2idx,:);
  
    a = edist(y(1,:),y(2,:));
    X([1,y2idx],:)=[];

    for i=1:size(y,2)
       dist = edist(y,X);
       [d, idx] = max(min(dist,[],1),[],2);
       if(d<t*a)
           %no more clusters
           break;
       else
           k = k+1;
           y(k,:) = X(idx,:); 
           X(idx,:) = [];
           %update a
           dist = edist(y,y);
           dist(dist==0) = [];
           a = mean(dist);
       end;
    end
    
    dist = edist(XBack,y);
    [~ , idxbest] = min(dist,[],2);
    centroids = [];
    for i=1:k
        centroids(i,:) = mean(XBack(idxbest==i,:),1);
    end
end
