%Ӧ��MATLAB�������Ԥ�⵹��������
[x,f,p]=wavread('E:\voice\record\chang1-0.wav');        % xΪȫ��������
x = double(x);
x = filter([1 -0.9375],1,x);
%x=filter([1-0.9375],1,x);

len=160;                    %���չ�����ÿһ֡�ź�ȡ20ms������8k�Ļ���ÿ֡160��������
y=enframe(x,len,len/2); % ��֡������һ�������֡��ѡ����0.5��֡��
[c,b]=size(y);   % ������������bΪ������ÿ�д���һ֡

for i = 1:c
yy = y(i,:);
s = yy' .*hamming(len);   %��ȡһ֡
p=10;           %pΪ����,lpc���������8k�Ĳ�����ѡ��10��Ϊ����
A=real(LPC3(s,p));      
lpc1=A;
a=lpc2lpcc(lpc1);
lpcc(i,:)=a;
 end
































