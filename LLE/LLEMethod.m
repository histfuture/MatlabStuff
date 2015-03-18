%LLE method
%X ��������,K����Ȩ�ص�local��,Ŀ��ά��
function [Y] = LLEMethod(X,K,d)
[D,N] = size(X);

% �ҵ��ٽ��� 
X2 = sum(X.^2,1);
distance = repmat(X2,N,1)+repmat(X2',1,N)-2*X'*X;
[sorted,index] = sort(distance);
neighborhood = index(2:(1+K),:);

% Ϊ��������Ȩ��
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

% ��������ľֲ��ؽ�Ȩֵ���������ڵ�����������������ֵ
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
