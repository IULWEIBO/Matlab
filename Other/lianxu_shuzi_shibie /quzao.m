function y=quzao(x)
%axis([1 1024 0 lOO1);
[c,l]=Wavedec(x,3,'db2');%����db2С�������źŽ�������ֽ�
ca3=appcoef(c,l,'db2',3);%��ȡС���ֽ�ĵ�Ƶϵ��
cd3=detcoef(c,l,3);%��ȡ������ĸ�Ƶϵ��
cd2=detcoef(c,l,2);%��ȡ�ڶ���ĸ�Ƶϵ��
cdl=detcoef(c,l,1);%��ȡ��һ��ĸ�Ƶϵ��
%��������Ĭ�Ϻ�ֵ�������봦��
%��ddencmp��������źŵ�Ĭ����ֵ��ʹ��wdencmp�������ʵ���������
[thr,sorh,keepapp]=den('den','wv',x);
thr=thr+0.3;
s2=wdencmp('gbl',c,l,'db2',3,thr,sorh,keepapp);
%axis([1 1024 0 lOO1),
y=s2;