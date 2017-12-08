clear all;
clc;
%��������Ӧ�Ӵ�Ƶ���ص��Ƚ��������˵���
N=512;%
Winsiz=512;%֡��
Shift=256;%֡��
[x,Fs]=wavread('G:\��ҵ�������\record\dang4-12.wav');
x=double(x);
%���ź���Ԥ���ش���
x=filter([1 -0.9375], 1, x);

nseg=floor((length(x)-Winsiz)/Shift)+1;
A=zeros(Winsiz/2+1,nseg);

%����ѭ����x�źŵļӴ������������Ƶ������
for i=1:nseg
    n1=(i-1)*Shift+1;n2=n1+(Winsiz-1);
    xx=x(n1:n2);xx=xx.*hamming(Winsiz);
    y=fft(xx,N);
    y=y(1:Winsiz/2+1);
    y=y.*conj(y);
    A(:,i)=y;
end
%����������
Esum=0;
for i=1:nseg
    for j=1:Winsiz/2
        Esum=Esum+A(j,i);
    end
end 
%�����Ǽ���ÿһ֡���׵�����
for i=1:nseg
    for n=1:Winsiz/2
        E(n,i)=A(n,i);
    end
end   
%�����Ǽ���ÿ֡��ÿ��������ĸ��ʷֲ�
for i=1:nseg
    for n=1:Winsiz/2
      P(n,i)=E(n,i)/Esum;  
    end
end
%�����Ǽ���ÿһ֡������ֵ
H=zeros(1,nseg);
for i=1:nseg
    for n=1:Winsiz/2
        H(i)=H(i)-P(n,i)*log(P(n,i)+eps);
    end
end  

figure(3);
%����wav�ļ��Ĳ��κͶ�Ӧ����Ϣ��
subplot(311)
plot(x);
subplot(312)
plot(H);
%Ϊ��������������������Ӱ�죬���ڰ�4�����һ�𣬱��һ�Ӵ���4*32=128 
Eb=zeros(64,nseg);Ebsum=0;
for i=1:nseg
    for m=1:64
        for k=(4*m-3):4*m
           Eb(m,i)=Eb(m,i)+E(k,i);
        end
        Ebsum=Ebsum+Eb(m,i);
    end
    
end   
%ʵ�����й�ʽ(8)
for i=1:nseg          
    for k=1:64
     Pb(k,i)=Eb(k,i)/Ebsum;
    end
end     
%ʵ�����й�ʽ(9)
Hb=zeros(1,nseg);
for i=1:nseg
    for k=1:64
        Hb(i)=Hb(i)-Pb(k,i)*log(P(k,i)+eps);
    end
end
%����wav�ļ��Ĳ��κͶ�Ӧ����Ϣ��
subplot(313)
plot(Hb);
    
