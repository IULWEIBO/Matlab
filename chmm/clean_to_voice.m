%���봿����������ʾ
x=wavread('G:\��ҵ�������\record\dang4-12.wav');
subplot(3,1,1);
plot(x);
axis([1 length(x) -1 1]);
x1=length(x);
%���������
SNR=5;
%��������Ⱥ������������Ҫ��ӵİ�����
clean_energy=sum(x.*x);
addnoise_energy=clean_energy*(10^-(SNR/10));
noise=normrnd(0,1,x1,1);
noise_energy=sum(noise.*noise);
q=addnoise_energy/noise_energy;
noise_new=sqrt(q)*noise;
%�ڴ��������м��������
y=x+noise_new;
%������д�������ļ�����ʾ
wavwrite(y,8000,'G:\voice\WN_clean.wav');
subplot(3,1,2);
plot(y);
axis([1 length(y) -1 1]);
