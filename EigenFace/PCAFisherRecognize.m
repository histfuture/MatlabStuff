%人脸模式分类，作业2-3 识别 k表示目标特征脸数量 ,返回错误率
%result 表示每个test被自动分到的类别
function [result, error] = PCAFisherRecognize(train,trainClass,test,testClass)
N = length(trainClass);
C = length((unique(trainClass)));
k = N - C;
%找到特征脸
[lowTrain,eigfaces,recoverTrain,error] = PCAMethod(train,k);

%应用Fisher鉴别准则，得到C-1个鉴别方向
[fisherTrain ,weight_lda] = FisherMethod(lowTrain,trainClass,C-1);

%分类评估
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
fprintf('pca 分类错误率 %f\n',(N-correct)/N);

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