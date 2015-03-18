%runExcise2，运行作业2的全部
%读取文件
% load('imgs.mat');
addpath('ORL');
parent='ORL\';
di=dir([parent '*.bmp']);
imgR = 112;%预先设定的每张图片的大小
imgC = 92;
dim = imgR*imgC;
nfeatures=0;
original = zeros(length(di),imgR*imgC);%原始参数
train = zeros(length(di)/2,imgR*imgC);%训练数据
test = zeros(length(di)/2,imgR*imgC);%测试数据
trainClass = zeros(length(di)/2,1);%监督信息
testClass = zeros(length(di)/2,1);
count = 0;
class = 1;
for i=1:length(di)
    count = count+1;
    image = imread([parent di(i).name]);
    original(i,:) = reshape(image',1,dim);%一行一个图片
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

%作业2-1 最小距离分类
fprintf('作业2-1 进行最小距离分类器分类\n');
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
fprintf('最小距离分类器出错率%f\n',error);

% % 作业2-2 PCA降维
fprintf('作业2-2 pca降维\n');
eigValues = [50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,250,300,400];%目标维度
pcaError = zeros(1,size(eigValues,1));
% 进行10次测试使用不同维度看错误率
parfor i=1:size(eigValues,2)
 [lowTrain,eigfaces,recoverTrain,error] = PCAMethod(original,eigValues(i));
 %打印第一张图片的降维版本
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
%作业2-3 eigenface+Fisherface
fprintf('作业2-3 eigenface+Fisherface\n');
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
fprintf('eigenface+Fisherface分类 错误率%f\n',error);



