clear all;
clc;
%����Ƶ�׷���������˵���
N=256;%
Winsiz=256;%֡��
Shift=80;%֡��
[x,Fs]=wavread('G:\��ҵ�������\record\dang4-1.wav');
x=double(x);
%���ź���Ԥ���ش���
x=filter([1 -0.9375], 1, x);
x=5*(x-mean(x));

nseg=floor((length(x)-Winsiz)/Shift)+1;
A=zeros(Winsiz/2,nseg);

%����ѭ����x�źŵļӴ������������Ƶ������
for i=1:nseg
    n1=(i-1)*Shift+1;n2=n1+(Winsiz-1);
    xx=x(n1:n2);xx=xx.*hamming(Winsiz);
    y=fft(xx,N);
    y=y(1:Winsiz/2);
    A(:,i)=abs(y);
end
%�跧ֵ
d=0;
d=var(A(:,1))+eps;
M=3*d;
%����Ƶ�����ж˵���
D=zeros(nseg,1);D1=zeros(nseg,1);
for i=1:nseg
    D(i)=var(A(:,i))+eps;
    if D(i)<=M
        D1(i)=d/5;
        else
       D1(i)=2*D(i); 
       
    end
end
% subplot(211),plot(x);
% 
% subplot(212),plot(D1);
figure(2);
subplot(2,1,1)
plot(x)
axis([1 length(x) -1 1])

 
subplot(2,1,2)
plot(D1);
axis([1 length(D1) 0 max(D1)])

    