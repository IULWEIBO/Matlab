%BP�������ʶ��ʵ��
%bp_test = bp_test(  x ,net)��xΪ���������,netΪBP����

function bp_test = bp_test(x ,net)
p=x';
[nb,minx,maxx]=premnmx(p);%��һ��

nc= sim(net,nb);    %��ѵ���õ�ģ�ͽ��з���
c=postmnmx(nc,minx,maxx);%����һ��
x=round(c);             %�������ʶ����
bp_test=c;
end