%LLE
%runExcise3
%读取文件
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


% %执行LLE 把训练集投影到2维平面上
[Y] = LLEMethod(original',5,2);%把训练集投影到二维平面上
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
fprintf('LLE分类 维度 %d 错误率%f\n',dims(i),error);
errors(i) = error;
end
figure(2);
plot(dims, errors,'-sr');



