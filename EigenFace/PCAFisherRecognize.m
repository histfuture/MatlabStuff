%����ģʽ���࣬��ҵ2-3 ʶ�� k��ʾĿ������������ ,���ش�����
%result ��ʾÿ��test���Զ��ֵ������
function [result, error] = PCAFisherRecognize(train,trainClass,test,testClass)
N = length(trainClass);
C = length((unique(trainClass)));
k = N - C;
%�ҵ�������
[lowTrain,eigfaces,recoverTrain,error] = PCAMethod(train,k);

%Ӧ��Fisher����׼�򣬵õ�C-1��������
[fisherTrain ,weight_lda] = FisherMethod(lowTrain,trainClass,C-1);

%��������
pcaTest =  test * eigfaces   ;

%evaluate nn on pca
distMat = edist(pcaTest,lowTrain);
[~ ,result] = min(distMat,[],2);
correct = 0;
for i=1:length(testClass)
%     fprintf('%d\t%d\t%d',testClass(i),i,trainClass(result(i)));
    if(testClass(i)==trainClass(result(i)))
        correct = correct+1;
    else
%             fprintf('error');
    end
%     fprintf('\n');
end
fprintf('pca ��������� %f\n',(N-correct)/N);

fisherTest = pcaTest * weight_lda;
%MD
distMat = edist(fisherTest,fisherTrain);
[~ ,result] = min(distMat,[],2);
correct = 0;
for i=1:length(testClass)
    if(testClass(i)==trainClass(result(i)))
        result(i) = trainClass(result(i));
        correct = correct+1;
    end
end
error = (N-correct)/N;
end