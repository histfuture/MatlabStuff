%dim表示目标维度
%result 表示每个test被自动分到的类别
function [result, error] = LLERecognize(train,trainClass,test,testClass,dim,k)
[Y] = LLEMethod([train;test]',k,dim);
Y = Y';
trainY = Y(1:size(train,1),:);
testY =  Y(size(train,1)+1:end,:);
[result,error] = MDNN(trainY,trainClass,testY,testClass);
%打印分类结果
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