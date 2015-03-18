%Fisher�б�,trainѵ������,trainClassѵ����Ŀ���
%dimĿ��ά��
%weight_lda ͶӰת������ , lowTrain trainͶӰ��fisher�ռ�ľ���
function [lowTrain,weight_lda] = FisherMethod(train,trainClass,dim)
k = dim;

% ��ֵ
meanvalue = mean(train, 1);
[sampleSize, dimsize]= size(train);
class = unique(trainClass);%���
class_num = length(class);%��Ŀ��
numInClass = zeros(class_num,1);
% ÿ����ľ�ֵ
classMean = zeros(class_num,dimsize);
for idx=1:class_num
    temClass = class(idx);
    sampleInClass = train(trainClass==temClass,:);
    classMean(idx,:) = mean(sampleInClass,1);
    numInClass(idx,1) = size(sampleInClass,1);
end


% ���������ɢ�Ⱦ���
sw = zeros(dimsize, dimsize);
for idx=1:class_num
    temClass = class(idx);
    temSample = train(trainClass==temClass,:);%�����ѵ����
    temMean = classMean(idx,:);%�����ƽ����
    temSample = bsxfun(@minus,temSample,temMean);%ѵ����������ƽ����
    sw = sw + temSample' * temSample;
end

% ��������ɢ�Ⱦ���
sb = zeros(dimsize, dimsize);
for idx=1:class_num
    Ni = numInClass(idx);%����ĸ���
    temMean = classMean(idx,:) - meanvalue;
    sb = sb + Ni * (temMean'*temMean);
end

%����ֵ�ֽ� ��� sb*w = eigValue * Sw * w
[evec, eval] = eig(sb', sw');
eval = diag(eval);
% ��������ֵ��С��������������
[~, index] = sort(eval, 'descend');
sortevec = evec(index,:);

% ����fisherfacesת������
weight_lda = sortevec(:,1:k);
lowTrain = train * weight_lda;
end