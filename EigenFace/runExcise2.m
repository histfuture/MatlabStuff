%runExcise2��������ҵ2��ȫ��
%��ȡ�ļ�
% load('imgs.mat');
addpath('ORL');
parent='ORL\';
di=dir([parent '*.bmp']);
imgR = 112;%Ԥ���趨��ÿ��ͼƬ�Ĵ�С
imgC = 92;
dim = imgR*imgC;
nfeatures=0;
original = zeros(length(di),imgR*imgC);%ԭʼ����
train = zeros(length(di)/2,imgR*imgC);%ѵ������
test = zeros(length(di)/2,imgR*imgC);%��������
trainClass = zeros(length(di)/2,1);%�ල��Ϣ
testClass = zeros(length(di)/2,1);
count = 0;
class = 1;
for i=1:length(di)
    count = count+1;
    image = imread([parent di(i).name]);
    original(i,:) = reshape(image',1,dim);%һ��һ��ͼƬ
    if count<=5
        idx =5*floor((i-1)/10)+count;
        train(idx,:) = original(i,:);
        trainClass(idx)=class;
    else
        idx =5*floor((i-1)/10)+count-5;
        test(idx,:) = original(i,:);
        testClass(idx)=class;
    end
    if(count==10)
        count=0;
        class = class+1;
    end
end

%��ҵ2-1 ��С�������
fprintf('��ҵ2-1 ������С�������������\n');
[result error] = MDNN(train,trainClass,test,testClass);
for i=1:length(testClass)
    realClass = testClass(i);
    myClass = result(i);
    fprintf('%d\t%d\t%d',realClass,i,myClass);
    if(realClass ~= myClass)
            fprintf('error');
    end
    fprintf('\n');
end
fprintf('��С���������������%f\n',error);

% % ��ҵ2-2 PCA��ά
fprintf('��ҵ2-2 pca��ά\n');
eigValues = [50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,250,300,400];%Ŀ��ά��
pcaError = zeros(1,size(eigValues,1));
% ����10�β���ʹ�ò�ͬά�ȿ�������
parfor i=1:size(eigValues,2)
 [lowTrain,eigfaces,recoverTrain,error] = PCAMethod(original,eigValues(i));
 %��ӡ��һ��ͼƬ�Ľ�ά�汾
 img = recoverTrain(1,:);
 img = reshape(img,imgC,imgR);
 img = img';
%  figure(i);
%  imshow(mat2gray(img));
 imwrite(mat2gray(img),['PCA/1' '-' num2str(eigValues(i)) '.bmp']);
 pcaError(1,i) = error;
end
plot(eigValues,pcaError,'-.s');
% 
%��ҵ2-3 eigenface+Fisherface
fprintf('��ҵ2-3 eigenface+Fisherface\n');
[result, error] = PCAFisherRecognize(train,trainClass,test,testClass);
for i=1:length(testClass)
    realClass = testClass(i);
    myClass = result(i);
    fprintf('%d\t%d\t%d',realClass,i,myClass);
    if(realClass ~= myClass)
            fprintf('error');
    end
    fprintf('\n');
end
fprintf('eigenface+Fisherface���� ������%f\n',error);



