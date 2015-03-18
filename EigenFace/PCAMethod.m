%使用pca 对人脸降维,train原始训练矩阵
%dim目标维度
%lowTrain低纬矩阵，eigfaces特征脸,recoverTrain恢复矩阵，error平均误差
function [lowTrain,eigfaces,recoverTrain,error] = PCAMethod(train,dim)
    k=dim;
    [u,r,v] = svds(train,k);
    lowTrain = train*v;
    eigfaces = v;
    recoverTrain = u*r*v';
    error = sum(((train - recoverTrain).^2),2);
    error = sqrt(error);
    error = mean(error,1);%平均误差
end