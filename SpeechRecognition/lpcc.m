function ccc=lpcc(x)

x = double(x);
x = filter([1 -0.9375],1,x);
%x=filter([1-0.9375],1,x);

len=160;                    %���չ�����ÿһ֡�ź�ȡ20ms������8k�Ļ���ÿ֡160��������
y=enframe(x,len,len/2); % ��֡����һ�������֡��ѡ����0.5��֡��

for i = 1:size(y,1)
    yy = y(i,:);
    s = yy' .*hamming(len);   %��ȡһ֡
    p=10;           %pΪ����,lpc���������8k�Ĳ�����ѡ��10��Ϊ����
    A=real(LPC3(s,p));      
    lpc1=A;
    a=lpc2lpcc(lpc1);
    lpcc(i,:)=a;
end
% ccc=lpcc;
m = lpcc(3:size(lpcc,1)-2,:);
ccc=m;
% ��ֲ���
% dtm = zeros(size(m));
% for i=3:size(m,1)-2
%     dtm(i,:) = -2*m(i-2,:)-m(i-1,:)+m(i+1,:)+2*m(i+2,:);
% end
% dtm = dtm/3;
% 
% �ϲ�mfcc������һ�ײ��mfcc����
% ccc = [m dtm];
% ȥ����β��֡����Ϊ����֡��һ�ײ�ֲ���Ϊ0
% ccc = ccc(3:size(m,1)-2,:);