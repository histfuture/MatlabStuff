% %ִ�����е���ҵһ������
% %��ȡ����
mat = load('iris.dat');
X = mat(:,1:4);
Class = mat(:,5)+1;%��1��ʼ����
% disp('ʹ��Cmeans�۳�3��,���ѡ���ʼ��');
% [initC,itcount,idxbest,Cbest] = Cmeans(X, 3,0);
% disp('��ʼ��');
% disp(initC);
% disp('��ֹ����');
% disp(Cbest);
% disp('������');
% for i=1:3
%     disp(['��' num2str(i) '��']);
%     disp(find(idxbest==i)');
% end
% fprintf('��������%d ������%f\n',itcount,EvaluateCluster(Class,idxbest,3));
% 
% disp('ʹ��Cmeans�۳�3��,ʹ��maxminѡ���ʼ��');
% [initC,itcount,idxbest,Cbest] = Cmeans(X, 3,1);
% disp('��ʼ��');
% disp(initC);
% disp('��ֹ����');
% disp(Cbest);
% disp('������');
% for i=1:3
%     disp(['��' num2str(i) '��']);
%     disp(find(idxbest==i)');
% end
% fprintf('��������%d ������%f\n',itcount,EvaluateCluster(Class,idxbest,3));

t = [0.5];
disp('MMD����');
error = zeros(1,length(t));

for tr = 1:length(t)

[centroids,idxbest] = MMD(X, t(tr));
disp('������');
disp(centroids);
for i=1:size(centroids,1)
    disp(['��' num2str(i) '��']);
    disp(find(idxbest==i)');
end
error(tr) = EvaluateCluster(Class,idxbest,size(centroids,1));
fprintf('��ֵ%f ������%f ������ %d\n',t(tr),error(tr),size(centroids,1));
end
plot(t,error,'-.rs');

% disp('ʹ���׾���۳�3�����ѡ��ʼ��');
% [~,itcount,idxbest] = SpectralClustering(X, 3,0);
% for i=1:3
%     disp(['��' num2str(i) '��']);
%     disp(find(idxbest==i)');
% end
% fprintf('��������%d ������%f\n',itcount,EvaluateCluster(Class,idxbest,3));
% 
% disp('ʹ���׾���۳�3����maxminѡ���ʼ��');
% [~,itcount,idxbest] = SpectralClustering(X, 3,1);
% for i=1:3
%     disp(['��' num2str(i) '��']);
%     disp(find(idxbest==i)');
% end
% fprintf('��������%d ������%f\n',itcount,EvaluateCluster(Class,idxbest,3));
