function mix = getmix(vector,M)
[mean esq nn] = kmeans(vector,M);

%����ÿ������ı�׼��Խ���ֻ����Խ����ϵ�Ԫ��
for j = 1:M
    ind = find(j==nn);
    tmp = vector(ind,:);
    var(j,:) = std(tmp);
end

%����ÿ�������е�Ԫ��������һ��Ϊ����pdf��Ȩ��
weight = zeros(M,1);
for j = 1:M
    weight(j) = sum(find(j==nn));
end
weight = weight/sum(weight);

%������
mix.M = M;
mix.mean = mean;
mix.var = var.^2;
mix.weight = weight;
