clc
clear
 k = 11;
 data_matrix=[];%����ѵ������
 data_matrix2=[];%�����������
%����ѵ�����ݣ�����ȡ����
T_train=[];
T_test=[];
for i=0:9
    for j=10:50
s = sprintf('09517/%i%i.wav',i,j);%�Ѹ�ʽ��������д��ĳ���ַ�����
[s1 fs1] = audioread(s);%��ȡ
v = mfcc(s1, fs1);%��ȡ��������
a= vqlbg(v, k); %����
data_matrix=[data_matrix,a(:)];
T_train=[T_train,i+1];
    end
end
 %����������ݣ�����ȡ����
for i=0:9
    for j=51:99
s = sprintf('09517/%i%i.wav',i,j);
[s1 fs1] = audioread(s);
v = mfcc(s1, fs1);
a= vqlbg(v, k); 
data_matrix2=[data_matrix2,a(:)];
T_test=[T_test,i+1];
    end
end
%�����ı�ǩ



% P_train=mapminmax(data_matrix,0,1)';%��һ
[P_train,settings] = mapminmax(data_matrix,0,1);
[P_test]=mapminmax(data_matrix2,'aply',settings);%��һ
Tn_train=BP(T_train');
Tn_test=BP(T_test');
P_train=P_train;
P_test=P_test;
net=newff(minmax(P_train),[200,10],{'tansig' 'tansig'} ,'traingda');%����һ����������
net.trainParam.show=500;
%ѵ������
net.trainParam.lr=0.5;
net.trainParam.epochs=25000;      %ѵ������ȡ5000
net.trainParam.goal=0.01;        %�������ȡ0.001
net=train(net,P_train,Tn_train); %ѵ��������
YY=sim(net,P_train);
[maxi,ypred]=max(YY);
maxi=maxi';
ypred=ypred';
CC=ypred-T_train';
n=length(find(CC==0));
Accuracytrain=n/size(P_train,2)%��ʶ��ı�ǩ����ʵ�ı�ǩ��һ���ĸ���,�Ӷ��������ȷ��

YY=sim(net,P_test);
[maxi,ypred]=max(YY);
maxi=maxi';
ypred=ypred';
CC=ypred-T_test';
n=length(find(CC==0));
Accuracytest=n/size(P_test,2)

%%��ȡ��������
s = sprintf('09517/0%i%i.wav',2,6); %�Ķ�·�� ����1 2���� 1�ĵ�2���� 2 3����2�ĵ�3�����Լ���ѡ��һ������
[s1 fs1] = audioread(s);%��ȡ
v = mfcc(s1, fs1);%��ȡ��������
a= vqlbg(v, k); %����
a=a(:);
b=mapminmax('apply',a,settings);%��һ
YY=sim(net,b);
[maxi,ypred]=max(YY);
leibie=ypred-1  %��ʾ����ǩ

save('yu_yin_shi_bie/neting.mat','settings','net'); 