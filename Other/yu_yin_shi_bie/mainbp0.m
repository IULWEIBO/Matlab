clc
clear
 k = 11;
 data_matrix=[];
 data_matrix2=[];
 %����ѵ�����ݣ�����ȡ����
for i=0:9
    for j=10:50
s = sprintf('09517/%i%i.wav',i,j);%�Ѹ�ʽ��������д��ĳ���ַ�����
[s1 fs1] = wavread(s);
v = mfcc(s1, fs1);
a= vqlbg(v, k); 
data_matrix=[data_matrix,a(:)];
    end
end
 %����������ݣ�����ȡ����
for i=0:9
    for j=51:99
s = sprintf('09517/%i%i.wav',i,j);
[s1 fs1] = wavread(s);
v = mfcc(s1, fs1);
a= vqlbg(v, k); 
data_matrix2=[data_matrix2,a(:)];
    end
end
%�����ı�ǩ
T_train=[1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,4,4,4,4,5,5,5,5,5,6,6,6,6,6,7,7,7,7,7,8,8,8,8,8,9,9,9,9,9,10,10,10,10,10]';
T_test=T_train;


P_train=mapminmax(data_matrix,0,1)';%��һ
[P_test,B]=mapminmax(data_matrix2,0,1);%��һ
P_test=P_test';
Tn_train=BP(T_train);
P_train=P_train';
P_test=P_test';
net=newff(minmax(P_train),[70,10],{'tansig' 'tansig'} ,'traingda');%����һ����������
net.trainParam.show=500;
%ѵ������
net.trainParam.lr=1;
net.trainParam.epochs=5000;      %ѵ������ȡ10000
net.trainParam.goal=0.001;        %�������ȡ0.01
net=train(net,P_train,Tn_train); %ѵ��������
YY=sim(net,P_train);
[maxi,ypred]=max(YY);
maxi=maxi';
ypred=ypred';
CC=ypred-T_train;
n=length(find(CC==0));
Accuracytrain=n/size(P_train,2)

YY=sim(net,P_test);
[maxi,ypred]=max(YY);
maxi=maxi';
ypred=ypred';
CC=ypred-T_test;
n=length(find(CC==0));
Accuracytest=n/size(P_test,2)

%%��ȡ��������
s = sprintf('data/%i%i.wav',2,6); %�Ķ�·�� ����1 2���� 1�ĵ�2���� 2 3����2�ĵ�3�����Լ���ѡ��һ������
[s1 fs1] = wavread(s);%��ȡ
v = mfcc(s1, fs1);%��ȡ��������
a= vqlbg(v, k); %����
a=a(:);
b=mapminmax('apply',a,B);%��һ
YY=sim(net,b);
[maxi,ypred]=max(YY);
leibie=ypred-1  %��ʾ����ǩ
