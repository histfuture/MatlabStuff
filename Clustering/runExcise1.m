% %执行所有的作业一的评估
% %读取数据
mat = load('iris.dat');
X = mat(:,1:4);
Class = mat(:,5)+1;%从1开始计数
% disp('使用Cmeans聚成3类,随机选择初始点');
% [initC,itcount,idxbest,Cbest] = Cmeans(X, 3,0);
% disp('初始点');
% disp(initC);
% disp('终止质心');
% disp(Cbest);
% disp('聚类结果');
% for i=1:3
%     disp(['第' num2str(i) '类']);
%     disp(find(idxbest==i)');
% end
% fprintf('迭代次数%d 错误率%f\n',itcount,EvaluateCluster(Class,idxbest,3));
% 
% disp('使用Cmeans聚成3类,使用maxmin选择初始点');
% [initC,itcount,idxbest,Cbest] = Cmeans(X, 3,1);
% disp('初始点');
% disp(initC);
% disp('终止质心');
% disp(Cbest);
% disp('聚类结果');
% for i=1:3
%     disp(['第' num2str(i) '类']);
%     disp(find(idxbest==i)');
% end
% fprintf('迭代次数%d 错误率%f\n',itcount,EvaluateCluster(Class,idxbest,3));

t = [0.5];
disp('MMD聚类');
error = zeros(1,length(t));

for tr = 1:length(t)

[centroids,idxbest] = MMD(X, t(tr));
disp('类中心');
disp(centroids);
for i=1:size(centroids,1)
    disp(['第' num2str(i) '类']);
    disp(find(idxbest==i)');
end
error(tr) = EvaluateCluster(Class,idxbest,size(centroids,1));
fprintf('阈值%f 错误率%f 类数量 %d\n',t(tr),error(tr),size(centroids,1));
end
plot(t,error,'-.rs');

% disp('使用谱聚类聚成3类随机选初始点');
% [~,itcount,idxbest] = SpectralClustering(X, 3,0);
% for i=1:3
%     disp(['第' num2str(i) '类']);
%     disp(find(idxbest==i)');
% end
% fprintf('迭代次数%d 错误率%f\n',itcount,EvaluateCluster(Class,idxbest,3));
% 
% disp('使用谱聚类聚成3类用maxmin选择初始点');
% [~,itcount,idxbest] = SpectralClustering(X, 3,1);
% for i=1:3
%     disp(['第' num2str(i) '类']);
%     disp(find(idxbest==i)');
% end
% fprintf('迭代次数%d 错误率%f\n',itcount,EvaluateCluster(Class,idxbest,3));
