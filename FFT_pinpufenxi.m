clc
clear
fs = 100; %����Ƶ��
N= 128;
n = 0:N-1;
t = n/fs;
f0 = 10;%�����ź�Ƶ��

x = sin(2*pi*f0*t);
figure(1);
subplot(2,3,1);
plot(t,x);
xlabel('ʱ��/s');
ylabel('��ֵ');
title('ʱ����');
grid;

y = fft(x,N);%����FFT�任
mag = abs(y);%���ֵ
f = (0:length(y)-1)'*fs/length(y);%���ж�Ӧ��Ƶ�ʱ任
subplot(2,3,2);
plot(f,mag);
axis([0,100,0,80])
xlabel('Ƶ��/Hz');
ylabel('��ֵ');
title('��Ƶ��ͼ');
grid;

sq = abs(y);%���������
subplot(2,3,3);
plot(f,sq);
xlabel('Ƶ��/Hz');
ylabel('��������');
title('��������ͼ');
grid;

power = sq.^2;%������
subplot(2,3,4);
plot(f,power);
xlabel('Ƶ��/Hz');
ylabel('������');
title('������ͼ');
grid;

ln = log(sq);%�������
subplot(2,3,5);
plot(f,ln);
xlabel('Ƶ��/Hz');
ylabel('������');
title('������ͼ');
grid;

xifft = ifft(y);%��IFFT�ָ�ԭʼ�ź�
magx = real(xifft);
ti = [0:length(xifft)-1]/fs;
subplot(2,3,6);
plot(ti,magx);
xlabel('ʱ��/s');
ylabel('��ֵ');
title('IFFT����źŲ���');
grid;