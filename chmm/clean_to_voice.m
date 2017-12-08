%读入纯净语音并显示
x=wavread('G:\毕业论文相关\record\dang4-12.wav');
subplot(3,1,1);
plot(x);
axis([1 length(x) -1 1]);
x1=length(x);
%给定信噪比
SNR=5;
%利用信噪比和语音能量求得要添加的白噪声
clean_energy=sum(x.*x);
addnoise_energy=clean_energy*(10^-(SNR/10));
noise=normrnd(0,1,x1,1);
noise_energy=sum(noise.*noise);
q=addnoise_energy/noise_energy;
noise_new=sqrt(q)*noise;
%在纯净语音中加入白噪声
y=x+noise_new;
%将数据写入语音文件并显示
wavwrite(y,8000,'G:\voice\WN_clean.wav');
subplot(3,1,2);
plot(y);
axis([1 length(y) -1 1]);
