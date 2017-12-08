%Daubechies8С��
%%%%%%��������%%%%%%%%%%%%%%%
s=wavread('jin1-4.wav');
subplot(2,1,2)
plot(s)
axis([1 length(s) -1 1])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=length(s);
y = 2/n*abs(fft(s,n)); %���и���Ҷ�任
%Pyy =y.*conj(y)/n;  %The power spectrum
%ff1= f*(0:410)/n;   
[c,l]=wavedec(s,5,'db8'); 
%ȡ��5���Ƶ����ϵ��
ca5=appcoef(c,l,'db8',5);
%ȡ�����Ƶϸ��ϵ��
cd5=detcoef(c,l,5);
cd4=detcoef(c,l,4);cd3=detcoef(c,l,3);
cd2=detcoef(c,l,2);cd1=detcoef(c,l,1);
%������Ƶ�ε�ϵ������
ca=zeros(1,length(ca5));   
c5=zeros(1,length(cd5));
c4=zeros(1,length(cd4));  
c3=zeros(1,length(cd3));
c2=zeros(1,length(cd2));
c1=zeros(1,length(cd1)); 
%�ع�ϵ������Ҫ���ع���5��ϸ�ڲ��֣�����ϵ�������㣬�õ���5��ϸ�ڶ�Ӧ��ֵ        
cc1=[ca,cd5,c4,c3,c2,c1];
%cc1=[ca6,c6,c5,c4,c3,c2,c1];
S2= waverec(cc1,l,'db8'); 
%���и���Ҷ�任
Y2 = 2/n*abs(fft(S2,n)); 
%ff2= f*(0:410)/n;   
%������
subplot(2,1,2)
plot(S2)
axis([1 length(S2) -1 1])
plot(S2);
title('Daubechies8 result');xlabel('the point number');ylabel('Amplitude/cm');
