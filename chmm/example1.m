%应用MATLAB求解线性预测倒谱主程序
[x,f,p]=wavread('E:\voice\record\chang1-0.wav');        % x为全部采样点
x = double(x);
x = filter([1 -0.9375],1,x);
%x=filter([1-0.9375],1,x);

len=160;                    %按照惯例，每一帧信号取20ms，采样8k的话，每帧160个采样点
y=enframe(x,len,len/2); % 分帧处理，一般情况下帧移选择在0.5个帧宽
[c,b]=size(y);   % 返回行列数，b为列数，每行代表一帧

for i = 1:c
yy = y(i,:);
s = yy' .*hamming(len);   %提取一帧
p=10;           %p为阶数,lpc计算阶数，8k的采样率选择10较为合适
A=real(LPC3(s,p));      
lpc1=A;
a=lpc2lpcc(lpc1);
lpcc(i,:)=a;
 end

































