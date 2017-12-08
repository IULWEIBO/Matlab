function prob = mixture(mix,x)
%����������� 
%���룺
% mix--��ϸ�˹�ṹ
% x--����������SIZE*1
%�����
% prob--�������

prob = 0;
for j=1:mix.M
    m = mix.mean(j,:);
    v = mix.var(j,:);
    w = mix.weight(j);
    prob = prob+w*pdf(m,v,x);
end

%��ֹlog(prob)���
if prob==0
    prob = realmin;
end
