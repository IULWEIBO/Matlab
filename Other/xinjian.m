clear;
clc;
%%%%%%%%�ɼ����������ָ�500000������%%%%%%%%%%%%%%%%%%%%%
x1=wavread('voice/1.wav');
x2=wavread('voice/2.wav');
x3=wavread('voice/3.wav');
x4=wavread('voice/4.wav');
%%%%%%%%%%%%%%%�������źŽ���Ԥ���ش���%%%%%%%%%%%%%%%%%%
len=length(x1);
heigt=0.98;
for i=2:len
    x1(i)=x1(i)-heigt*x1(i-1);
end
for i=2:len
    x2(i)=x2(i)-heigt*x2(i-1);
end
for i=2:len
    x3(i)=x3(i)-heigt*x3(i-1);
end
 for i=2:len
   x4(i)=x4(i)-heigt*x4(i-1);
end
%%%%%%%%%%%%%%MEL�����˲�����%%%%%%%%%%%%%%%%%%%%%%%%%%%
fh=20000;
melf=2595*log(1+fh/700);
M=24;
i=0:25;
f=700*(exp(melf/2595*i/(M+1))-1);
N=256;
for m=1:24
    for k=1:256
        x=fh*k/N;
        if (f(m)<=x)&&(x<=f(m+1))
            F(m,k)=(x-f(m))/(f(m+1)-f(m));
        else if (f(m+1)<=x)&&(x<=f(m+2))
                F(m,k)=(f(m+2)-x)/(f(m+2)-f(m+1));
            else
                F(m,k)=0;
            end
        end
    end
end
m=N/2;
for k=1:12
  n=0:23;
  dctcoef(k,:)=cos((2*n+1)*k*pi/(2*24));
end
count=floor(length(x1)/m);
%%%%%%%%%%%%%%%����������������������ȡ%%%%%%%%%%%
c1=zeros(count,12);
for i=1:count-2
    x_frame=x1(m*(i-1)+1:m*(i-1)+N);
    Fx=abs(fft(x_frame));
    s=log(Fx.^2*F');
    c1(i,:)=s*dctcoef';
end
c2=zeros(count,12);
for i=1:count-2
    x_frame=x2(m*(i-1)+1:m*(i-1)+N);
    Fx=abs(fft(x_frame));
    s=log(Fx.^2*F');
    c2(i,:)=s*dctcoef';
end
c3=zeros(count,12);
for i=1:count-2
    x_frame=x3(m*(i-1)+1:m*(i-1)+N);
    Fx=abs(fft(x_frame));
    s=log(Fx.^2*F');
    c3(i,:)=s*dctcoef';
end
c4=zeros(count,12);
  for i=1:count-2
    x_frame=x4(m*(i-1)+1:m*(i-1)+N);
   Fx=abs(fft(x_frame));
    s=log(Fx.^2*F');
    c4(i,:)=s*dctcoef';
end
%save c1 c1
%save c2 c2
%save c3 c3
%save c4 c5
%�ĸ������źž���ϳ�һ������
data(1:1000,:)=c1(1:1000,:);
data(1001:2000,:)=c2(1:1000,:);
data(2001:3000,:)=c3(1:1000,:);
data(3001:4000,:)=c4(1:1000,:);
%data=cat(1,c1,c2,c3,c4);
%%%%%%%%%%%�����źŵ�һ��Ϊ�������%%%%%%%%%%%%%%

for i=1:4000
    if (i>=1)&&(i<=1000)
        data(i,1)=1;
    else if(i>=1001)&&(i<=2000)
            data(i,1)=2;
        else if (i>=2001)&&(i<=3000)
                data(i,1)=3;
            else
                data(i,1)=4;
            end
        end
    end
end
%��1��2000���������
k=rand(1,4000);
[m,n]=sort(k);
%�����������
input=data(:,2:12);
output1 =data(:,1);
%�������1ά���4ά
for i=1:4000
    switch output1(i)
        case 1
            output(i,:)=[1 0 0 0];
        case 2
            output(i,:)=[0 2 0 0];
        case 3
            output(i,:)=[0 0 3 0];
        case 4
            output(i,:)=[0 0 0 4];
    end
end
%�����ȡ1500������Ϊѵ��������500������ΪԤ������
input_train=input(n(1:3500),:)';
output_train=output(n(1:3500),:)';
input_test=input(n(3501:4000),:)';
output_test=output(n(3501:4000),:)';
%�������ݹ�һ��
[inputn,inputps]=mapminmax(input_train);
%% ����ṹ��ʼ��
innum=11;
midnum=12;
outnum=4;
 
%Ȩֵ��ʼ��
w1=rands(midnum,innum);
b1=rands(midnum,1);
w2=rands(midnum,outnum);
b2=rands(outnum,1);
w2_1=w2;w2_2=w2_1;
w1_1=w1;w1_2=w1_1;
b1_1=b1;b1_2=b1_1;
b2_1=b2;b2_2=b2_1;

%ѧϰ��
xite=0.1;
alfa=0.01;
%% ����ѵ��
for ii=1:10
    E(ii)=0;
    for i=1:1:3500
       %% ����Ԥ�����
        x=inputn(:,i);
        % ���������
        for j=1:1:midnum
            I(j)=inputn(:,i)'*w1(j,:)'+b1(j);
            Iout(j)=1/(1+exp(-I(j)));
        end
        % ��������
        yn=w2'*Iout'+b2;
       
       %% Ȩֵ��ֵ����
        %�������
        e=output_train(:,i)-yn;    
        E(ii)=E(ii)+sum(abs(e));
       
        %����Ȩֵ�仯��
        dw2=e*Iout;
        db2=e';
       
        for j=1:1:midnum
            S=1/(1+exp(-I(j)));
            FI(j)=S*(1-S);
        end     
        for k=1:1:innum
            for j=1:1:midnum
                dw1(k,j)=FI(j)*x(k)*(e(1)*w2(j,1)+e(2)*w2(j,2)+e(3)*w2(j,3)+e(4)*w2(j,4));
                db1(j)=FI(j)*(e(1)*w2(j,1)+e(2)*w2(j,2)+e(3)*w2(j,3)+e(4)*w2(j,4));
            end
        end
          
        w1=w1_1+xite*dw1';
        b1=b1_1+xite*db1';
        w2=w2_1+xite*dw2';
        b2=b2_1+xite*db2';
       
        w1_2=w1_1;w1_1=w1;
        w2_2=w2_1;w2_1=w2;
        b1_2=b1_1;b1_1=b1;
        b2_2=b2_1;b2_1=b2;
    end
end
 
%% ���������źŷ���
inputn_test=mapminmax('apply',input_test,inputps);
for ii=1:1
    for i=1:500
        %���������
        for j=1:1:midnum
            I(j)=inputn_test(:,i)'*w1(j,:)'+b1(j);
            Iout(j)=1/(1+exp(-I(j)));
        end
       
        fore(:,i)=w2'*Iout'+b2;
    end
end

%% �������
%������������ҳ�������������
for i=1:500
    output_fore=find(fore(:,i)==max(fore(:,i)));
end
%BP����Ԥ�����
error=output_fore-output1(n(3501:4000))';
 
%����Ԥ�����������ʵ����������ķ���ͼ
figure(1)
plot(output_fore,'r')
hold on
plot(output1(n(3501:4000))','b')
legend('Ԥ���������','ʵ���������')
%�������ͼ
figure(2)
plot(error)
title('BP����������','fontsize',12)
xlabel('�����ź�','fontsize',12)
ylabel('�������','fontsize',12)
%print -dtiff -r600 1-4
k=zeros(1,4); 
%�ҳ��жϴ���ķ���������һ��
for i=1:500
    if error(i)~=0
        [b,c]=max(output_test(:,i));
        switch c
            case 1
                k(1)=k(1)+1;
            case 2
                k(2)=k(2)+1;
            case 3
                k(3)=k(3)+1;
            case 4
                k(4)=k(4)+1;
        end
    end
end
%�ҳ�ÿ��ĸ����
kk=zeros(1,4);
for i=1:500
    [b,c]=max(output_test(:,i));
    switch c
        case 1
            kk(1)=kk(1)+1;
        case 2
            kk(2)=kk(2)+1;
        case 3
            kk(3)=kk(3)+1;
        case 4
            kk(4)=kk(4)+1;
    end
end
%��ȷ��
rightridio=(kk-k)./kk