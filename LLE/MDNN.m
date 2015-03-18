%MDNN ���������䵽�����ѵ�����ĵ�����
function [result error] = MDNN(train,trainClass,test,testClass)
    distMat = edist(test,train);
    [minvalue,minIdx] = min(distMat,[],2);
    result = zeros(size(minIdx));
    correct = 0;
    for i=1:size(minIdx)
        result(i) = trainClass(minIdx(i));
        correct = correct+ (result(i)==testClass(i));
    end
    error = 1 - correct / size(test,1);
end