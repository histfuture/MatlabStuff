%Fisher判别法,train训练矩阵,trainClass训练类目标记
%dim目标维度
%weight_lda 投影转换矩阵 , lowTrain train投影到fisher空间的矩阵
function [lowTrain,weight_lda] = FisherMethod(train,trainClass,dim)
k = dim;

% 均值
meanvalue = mean(train, 1);
[sampleSize, dimsize]= size(train);
class = unique(trainClass);%类别
class_num = length(class);%类目数
numInClass = zeros(class_num,1);
% 每个类的均值
classMean = zeros(class_num,dimsize);
for idx=1:class_num
    temClass = class(idx);
    sampleInClass = train(trainClass==temClass,:);
    classMean(idx,:) = mean(sampleInClass,1);
    numInClass(idx,1) = size(sampleInClass,1);
end


% 求的类内离散度矩阵
sw = zeros(dimsize, dimsize);
for idx=1:class_num
    temClass = class(idx);
    temSample = train(trainClass==temClass,:);%该类的训练集
    temMean = classMean(idx,:);%该类的平均脸
    temSample = bsxfun(@minus,temSample,temMean);%训练集都减掉平均脸
    sw = sw + temSample' * temSample;
end

% 求的类间离散度矩阵
sb = zeros(dimsize, dimsize);
for idx=1:class_num
    Ni = numInClass(idx);%该类的各数
    temMean = classMean(idx,:) - meanvalue;
    sb = sb + Ni * (temMean'*temMean);
end

%特征值分解 求解 sb*w = eigValue * Sw * w
[evec, eval] = eig(sb', sw');
eval = diag(eval);
% 根据特征值大小对特征向量排序
[~, index] = sort(eval, 'descend');
sortevec = evec(index,:);

% 计算fisherfaces转换向量
weight_lda = sortevec(:,1:k);
lowTrain = train * weight_lda;
end