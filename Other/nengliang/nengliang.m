%�������źŲ�����֡
clear
clc
X= wavread('666.wav');
%���źŽ���Ԥ����
x=X;
x4=filter([1,-0.9375],1,x);
figure(1)
subplot(2,1,1),plot(x)
title('ԭʼ�����ź�');
xlabel('��������n');
ylabel('��ֵ');
subplot(2,1,2),plot(x4)
title('ԭʼ�����źŵ�Ԥ����');
xlabel('��������n');
ylabel('��ֵ');


   
% ���ȹ�һ����[��1��1]
x=double(x);
x=x/max(abs(x));
% ��������
FrameLen=240;       % ֡��ȡ30ms,8kHz�Ĳ�����
FrameInc=80;        % ֡��ȡ10ms,1/3
amp1=3;            
amp2=2;              
zcr1=10;            
zcr2=5;                
maxsilence=3;        % 3*10ms=30ms
minlen=15;          % 15*10ms=150ms   
status=0;
count=0;
silence=0; 


% ��ʱ������(ʸ����)
tmp1=enframe(x(1:length(x)-1),FrameLen,FrameInc);
tmp2=enframe(x(2:length(x)),FrameLen,FrameInc);
signs=(tmp1.*tmp2)< 0;
diffs=(tmp1-tmp2)> 0.02;
zcr=sum(signs.*diffs,2);
figure(2)
subplot(2,1,1)
plot(zcr);
title('��ʱ������');
ylabel('zcr')

%�����ʱ����
amp=sum(abs(enframe(filter([1-0.9375],1,x),FrameLen,FrameInc)),2);
inz=find(amp>1);
amm=amp(inz);
ll=min(amm);
figure(2)
subplot(2,1,2)
plot(amp);
title('��ʱ����');
ylabel('amp')


%������������ 
amp1 = min(amp1, max(amp)/4);
amp2 = min(amp2, max(amp)/8);
%amp1=ll+(max(amp)-ll)/8;
%amp2=ll+(max(amp)-ll)/16;
%��ʼ�˵���
x1=0;
x2=0;
for n=1:length(zcr)
    goto = 0;
    switch status 
        case{0,1}                    % 0=������1=���ܿ�ʼ
            if amp(n) > amp1         % ȷ�Ž���������
                x1=max(n-count-1,1);
                status=2;
                silence=0;
                count=count+1;
            elseif amp(n) >amp2 | zcr(n) > zcr2     % ���ܴ���������
                status=1;
                count=count+1;
            else                                    % ����״̬ 
                status=0;
                count=0;
            end
        case 2,                                     % 2=������
            if amp(n) > amp2 | zcr(n) > zcr2        % ������������
                count=count+1;
            else
                silence=silence+1;
                if silence < maxsilence    % ����������������δ����
                   count=count+1;
                elseif count < minlen      % ��������̫�̣���Ϊ������
                   status=0;
                   silence=0;
                   count=0;
                else                       % ��������
                   status=3;
                end
            end
        case 3,                       % 3=��������    
            break;
    end
end
count=count-silence;
x2=x1+count-1;                  
figure(3)
subplot(2,1,1)
plot(x)
title('�����źŵĶ˵���');
axis([1 length(x) -1 1])
ylabel('Speech');
line([x1*FrameInc x1*FrameInc],[-1,1],'color','red');
line([x2*FrameInc x2*FrameInc],[-1,1],'color','red');

%n1=(x1*FrameInc-x2*FrameInc)+1;
yy=x(x1*FrameInc:x2*FrameInc);%x1*FrameInc=3760,x2=8320,
 %yy�ĳ�����4560
figure(3)
subplot(2,1,2)
plot(yy)
axis([1 length(yy) -1 1]) %���˴��ĺ������ֵ�Ϳ���ȡ��ͬ�����������������������Σ�
title('ԭʼ�����źŽ��ж˵����õ������õ������źŶ�')



fs=11.025;%�趨����Ƶ��
y=fft(yy);%����fft�任
mag=abs(y);%���ֵ
f=(0:length(y)-1)'*fs/length(y);%���ж�Ӧ��Ƶ��ת��
figure(4);
plot(f,mag);%��Ƶ��ͼ
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('�źŲ���Ƶ��ͼ');
grid;

z=0.1*rand(1,length(yy));
figure(5);
plot(z)

fs=11.025;%�趨����Ƶ��
Z=fft(z);%����fft�任
mag=abs(Z);%���ֵ
f=(0:length(Z)-1)'*fs/length(Z);%���ж�Ӧ��Ƶ��ת��
figure(6);
plot(f,mag);%��Ƶ��ͼ
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('��������Ƶ��ͼ')
grid;

m=yy'+z;
figure(7);
subplot(2,1,1);
plot(m)


fs=11.025;%�趨����Ƶ��
M=fft(m);%����fft�任
mag=abs(M);%���ֵ
f=(0:length(M)-1)'*fs/length(M);%���ж�Ӧ��Ƶ��ת��
figure(8);
plot(f,mag);%��Ƶ��ͼ
xlabel('Ƶ��(Hz)');
ylabel('��ֵ');
title('����źŲ���Ƶ��ͼ')
grid;


%wavwrite(m,'s01')

