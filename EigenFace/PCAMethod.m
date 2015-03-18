%ʹ��pca ��������ά,trainԭʼѵ������
%dimĿ��ά��
%lowTrain��γ����eigfaces������,recoverTrain�ָ�����errorƽ�����
function [lowTrain,eigfaces,recoverTrain,error] = PCAMethod(train,dim)
    k=dim;
    [u,r,v] = svds(train,k);
    lowTrain = train*v;
    eigfaces = v;
    recoverTrain = u*r*v';
    error = sum(((train - recoverTrain).^2),2);
    error = sqrt(error);
    error = mean(error,1);%ƽ�����
end