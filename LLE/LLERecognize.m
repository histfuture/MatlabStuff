%dim��ʾĿ��ά��
%result ��ʾÿ��test���Զ��ֵ������
function [result, error] = LLERecognize(train,trainClass,test,testClass,dim,k)
[Y] = LLEMethod([train;test]',k,dim);
Y = Y';
trainY = Y(1:size(train,1),:);
testY =  Y(size(train,1)+1:end,:);
[result,error] = MDNN(trainY,trainClass,testY,testClass);
%��ӡ������
% for i=1:length(testClass)
%     realClass = testClass(i);
%     myClass = result(i);
%     fprintf('%d\t%d\t%d',realClass,i,myClass);
%     if(realClass ~= myClass)
%         fprintf('error');
%     end
%     fprintf('\n');
% end
end