x = wavread('G:\��ҵ�������\record\chang1-5.wav');
[x1 x2] = vad(x);
m = mfcc(x);
for i=1:size(m,2)
    sum(i)=0;
    for j=1:size(m,1)
        sum(i)=sum(i)+m(j,i);
    end
end
sum=abs(sum)/24;
figure(1)
subplot(3,1,1)
plot(m(:,1))
axis([0 100 -10 20])
xlabel('����5�ĵ�һάMFCCϵ��');
subplot(3,1,2)
plot(m(:,2))
axis([0 100 -10 20])
xlabel('����5�ĵڶ�άMFCCϵ��');
subplot(3,1,3)
plot(m)
axis([0 100 -30 30])
xlabel('����5��������24άMFCCϵ��');
figure(2)
bar(sum)
axis([1 length(sum) 0 25])