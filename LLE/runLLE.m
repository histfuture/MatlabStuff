%LLE
%runExcise3
%��ȡ�ļ�
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


% %ִ��LLE ��ѵ����ͶӰ��2άƽ����
[Y] = LLEMethod(original',5,2);%��ѵ����ͶӰ����άƽ����
Y = Y';
hold on;
currClass = 0;
color = [0,0,0];
figure(1);
for i = 1:length(trainClass)
temY = Y(trainClass==i,:);
plot(temY(:,1), temY(:,2),'o','color',rand(1,3));
end
hold off;


dims = [2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100,150,200];
errors = zeros(1,length(dims));
for i = 1:length(dims)
[result, error] = LLERecognize(train,trainClass,test,testClass,dims(i),10);
fprintf('LLE���� ά�� %d ������%f\n',dims(i),error);
errors(i) = error;
end
figure(2);
plot(dims, errors,'-sr');



