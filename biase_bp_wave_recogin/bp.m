%BP�������ʵ��
%bp_data = bp( x)��xΪ���������

function bp_data = bp( x )
p=x';
[nb,minx,maxx]=premnmx(p);
a=[1,2,3,4,5,6,7,8,9,10];
t=a';
net=newff(minmax(nb),[280,17,10],{'purelin','logsig','purelin'},'traingdx'); 
net.trainParam.show=50; %50�ֻ���ʾһ�ν��
net.trainParam.lr=0.05; %ѧϰ�ٶ�Ϊ0.05
net.trainParam.epoch=1500; %���ѵ���ֻ�Ϊ1000��
net.trainParam.goal=0.001; %�������Ϊ0.001
net=train(net,nb,t);    %��ʼѵ��
y1= sim(net,nb);    %��ѵ���õ�ģ�ͽ��з���
plot(y1);
bp_data=net;
end


