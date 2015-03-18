clear
load 'iris.csv'

train = iris(:,1:4);
maxv = max(train);
minv = min(train);
train = bsxfun(@minus,train,minv);
train = bsxfun(@rdivide,train,(maxv-minv));

randIndex = randperm(size(iris,1));
dataset = iris(randIndex,:);
ratio = 0.7;
k = 10;
ts = floor(ratio * size(iris,1));

trainMat = dataset(1:ts,:);
testMat = dataset(ts+1:end,:);
KNN(trainMat(:,1:4),testMat(:,1:4),trainMat(:,5),testMat(:,5),k)