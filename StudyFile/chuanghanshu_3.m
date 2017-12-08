clc
clear

close all
N = 32;
nn = 0:N-1;

figure(1); 

subplot(3,1,1);
w = boxcar(N);
stem(nn,w);
xlabel('����');
ylabel('����');
title('���δ�');

subplot(3,1,2);

w = hamming(N);
stem(nn,w);
xlabel('����');
ylabel('����');
title('������');

subplot(3,1,3);
w = hanning(N);
stem(nn,w);
xlabel('����');
ylabel('����');
title('������');