function KNN(train,test,trl,tel,topk)
    maxv = max(train);
    minv = min(train);
    train = bsxfun(@minus,train,minv); 
    train = bsxfun(@rdivide,train,(maxv-minv));    
    test = bsxfun(@minus,test,minv) ;
    test = bsxfun(@rdivide,test,(maxv-minv));

    dist = pdist2(test,train);
    [dist,index] = sort(dist,2);
    index = index(:,1:topk);
    
    result = zeros(size(index,1),1);
    for i = 1 : size(index,1)
        idx = index(i,:);
        result(i) = mode (trl(idx,:));
    end
    result = result==tel;
    disp(1 - length(find(result==0))/length(tel))
end