[x]=wavread('G:\��ҵ�������\record\dang4-12.wav');
%��һ��������������
w = 1+6*sin(pi*[1:12]./12);
w = w/max(w);

%Ԥ�����˲���
y = double(x);
y = y / max(abs(x));
yy = filter([1 -0.9375],1,y);

%�����źŷ�֡
N=160;
zz = enframe(yy,N,80);

subplot(311)
plot(x)
axis([1 length(x) -1 1])
ylabel('Speech');
title('ԭʼ�����ź�')

subplot(312)
plot(yy);
axis([1 length(yy) -1 1])
ylabel('Speech');
title('�˲���������ź�')

subplot(313)
plot(zz);
axis([1 length(zz) -1 1])
ylabel('Speech');
title('�Ӵ���֡��������ź�')