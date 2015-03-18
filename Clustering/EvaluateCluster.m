% Pt���ĵ����������п����ĵ��Ե���Ŀ�����ĵ�����Ϊn����Pt=n*(n-1)/2    
% Tm���˹����������п��ܵ��ĵ�������    
% Ta�������������п��ܵ��ĵ�����    
% Ei�����������ָ�ھ������г��֣������˹�������û�г��ֵ��ĵ���������    
% Em����©������ָ���˹������г��֣����ھ�������û�г��ֵ��ĵ�������    
% ��������ʣ�CE�� = ��������� + ��©������/�ĵ����������п��ܵ��ĵ�������=(Ea + Em)/Pt
% ����ȫ���ʣ�CA�� =  ��ȷ������/�˹��������ĵ��Ե����� = (Ta - Ei) / Tm
% ����׼ȷ�ʣ�CP�� =  ��ȷ������/���������ĵ��Ե����� = (Ta - Ei) / Ta

% x�˹����࣬y������,k������
function error = EvaluateCluster(X,Y,k)
n = size(X,1);
pt = n*(n-1)/2;

matPairTrue = zeros(n,n);%�˹��������
matPairAuto = zeros(n,n);%�Զ��������


for i=1:k
    clusterX = find(X==i);
    for j = 1:length(clusterX)
        for m = i:length(clusterX)
            matPairTrue(j,m) = 1;
            matPairTrue(m,j) = 1;
        end
    end
end

for i=1:k
    clusterY = find(Y==i);
    for j = 1:length(clusterY)
        for m = i:length(clusterY)
            matPairAuto(j,m) = 1;
            matPairAuto(m,j) = 1;
        end
    end
end


error = 0;
for i=1:n
    for j=i:n
        if(i~=j)
            if(matPairTrue(i,j)~=matPairAuto(i,j))
                error = error+1;
            end
        end
    end
end

error = error / pt; 



end