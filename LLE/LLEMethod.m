%LLE method
%X 样本矩阵,K计算权重的local域,目标维度
function [Y] = LLEMethod(X,K,d)
[D,N] = size(X);

% 找到临近域 
X2 = sum(X.^2,1);
distance = repmat(X2,N,1)+repmat(X2',1,N)-2*X'*X;
[sorted,index] = sort(distance);
neighborhood = index(2:(1+K),:);

% 为领进域分配权重
if(K>D) 
  tol=1e-3; 
else
  tol=0;
end
W = zeros(K,N);
for ii=1:N
   z = X(:,neighborhood(:,ii))-repmat(X(:,ii),1,K);
   C = z'*z;                                        
   C = C + eye(K,K)*tol*trace(C);                  
   W(:,ii) = C\ones(K,1);                           
   W(:,ii) = W(:,ii)/sum(W(:,ii));                 
end;

% 由样本点的局部重建权值矩阵和其近邻点计算出该样本点的输出值
M = sparse(1:N,1:N,ones(1,N),N,N,4*K*N); 
for ii=1:N
   w = W(:,ii);
   jj = neighborhood(:,ii);
   M(ii,jj) = M(ii,jj) - w';
   M(jj,ii) = M(jj,ii) - w;
   M(jj,jj) = M(jj,jj) + w*w';
end;


options.disp = 0; options.isreal = 1; options.issym = 1; 
[Y,eigenvals] = eigs(M,d+1,0,options);
Y = Y(:,1:d)'*sqrt(N); 
