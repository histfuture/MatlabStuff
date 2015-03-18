%X������������k���������Ŀ��isMaxMinCentroid��ʾ�Ƿ�Ҫ�������С��������ʼ����ѡ��
%initC��ʼ������,itcount,����������idxbest��������Cbest��ʾ������
function [initC,itcount,idxbest,Cbest] = Cmeans(X, k,isMaxMinCentroid)
err = 0.001;
maxiter= 100;
initC = [];
if (isMaxMinCentroid == 1)
    %�����С���� 
    initC(1,:) = X(1,:);
    for i = 2:k
        dist = edist(initC,X);
        mind = min(dist,[],1);
        [m,index] = max(mind,[],2);
        initC(i,:) = X(index,:);
    end
    
else
    index = randperm(size(X,1));
    initC = X(index(1:k),:);
end

stopErr = inf; 
iter = 1;
centroid = initC;
while(stopErr > err && iter < maxiter )
    %��������
   distMat = edist(X,centroid);
   [m,idxbest] = min(distMat,[],2);
   newC = centroid;
   %new centroid
   for idx=1:k
       newC(idx,:) = mean(X((idxbest==idx),:),1);
   end
   stopErr = max(sum((newC - centroid).^2,2));
   centroid = newC;
   iter = iter+1;
end
Cbest = centroid;
itcount = iter-1;
end
