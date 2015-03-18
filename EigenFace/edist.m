%计算欧式距离 接收x，y两个维度一样的矩阵，计算x中的向量和y中的向量的距离
function dist=edist(x,y)
    dist = zeros(size(x,1),size(y,1));
    for i = 1:size(x,1)
        tem = bsxfun(@minus,y,x(i,:));
        tem = tem.^2;
        tem = sum(tem,2);
        dist(i,:) = sqrt(tem');
    end
end
