%����ŷʽ���� ����x��y����ά��һ���ľ��󣬼���x�е�������y�е������ľ���
function dist=edist(x,y)
    dist = zeros(size(x,1),size(y,1));
    for i = 1:size(x,1)
        tem = bsxfun(@minus,y,x(i,:));
        tem = tem.^2;
        tem = sum(tem,2);
        dist(i,:) = sqrt(tem');
    end
end
