%================================��⵹�׳�����ÿһ֡Ϊ��λ
function lpcc=lpc2lpcc(lpc1)       %lpc1Ϊ����Ԥ�����
n_lpc=10;
n_lpcc=12;
lpcc=zeros(1,n_lpcc);                %12��Ԫ�ص����飬�����������
lpcc(1)=lpc1(1);                     %��һ��ֵ��ͬ

for n=2:n_lpc                       %��8ǰ��Ľ���
    lpcc(n)=lpc1(n);
        for l=1:n-1 
        lpcc(n)=lpcc(n)+lpc1(l)*lpcc(n-l)*(n-l)/n;
         end
end

for n=n_lpc+1:n_lpcc                     %��8����Ľ���
    lpcc(n)=0;
    for l=1:n_lpc
     lpcc(n)=lpcc(n)+lpc1(l)*lpcc(n-l)*(n-l)/n;
    end
end

% lpcc=-lpcc;