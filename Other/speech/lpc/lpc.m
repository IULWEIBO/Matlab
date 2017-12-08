close all
clear
clc
[x,fs]=audioread('0.wav');%��������
% Ԥ�����˲���
xx=double(x);
y=filter([1 -0.9495],1,xx);
N=160;
y1=y(1:N);
w1=hamming(N);
y2=(y1 .* w1)';%�Ӵ� ȡһ֡����
p=30;%Ԥ�����
%����������غ���
r=zeros(1,p+1);
for k=1:p+1
sum=0;
for m=1:N+1-k
sum=sum+y2(m) .* y2(m-1+k)';
end
r(k)=sum;
end
%����durbin�㷨������Ԥ��ϵ��
k=zeros(1,p);
k(1)=r(2)/r(1);
a=zeros(p,p);
a(1,1)=k(1);
e=zeros(1,p);
e(1)=(1-k(1)^2)*r(1);
%���ƹ���
for i=2:p
c=zeros(1,i);
sum=0;
for j=1:i-1
sum=sum+(a(i-1,j).*r(i+1-j));
end
c(i)=sum;
k(i)=(r(i+1)-c(i))/e(i-1);%����ϵ��
if find(abs(k)>1) 
    disp('default')
else
subplot(413);plot(abs(k));title('|k(i)|<=1')
end
a(i,i)=k(i);
for j=1:i-1
a(i,j)=a(i-1,j)-k(i).*a(i-1,i-j);
end
e(i)=(1-k(i)^2)*e(i-1);%Ԥ�����в�����
subplot(414);plot(e);title('Ԥ�����в�����E(i)')
end
%���ƽ�������ȡԤ��ϵ��
d=zeros(1,p);
for t=1:p
d(t)=a(p,t);
end
z=zeros(1,N);
for i=1:p
z(i)=y2(i);

end
figure(1);
subplot(411);plot(y2);title('ԭʼ����')
subplot(412);plot(z);title('durbin�㷨������Ԥ��ϵ��')

