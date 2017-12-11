clc
clear

k = 11;
data_matrix=[];%����ѵ������
data_matrix2=[];%�����������

%0~9ÿ������¼10�飬ѵ������Ϊ00��01��02��... ��09
%��������Ϊ000��001��002��... ��009
%ÿ�������ٷֱ�¼��һ�� 0��1��2��... ��9

%����ѵ�����ݣ�����ȡ����
T_train=[];
T_test=[];
for i=0:9
    for j=0:9
        s = sprintf('voice_data/train/%i%i.wav',i,j);%�Ѹ�ʽ��������д��ĳ���ַ�����
        [s1 fs1] = audioread(s);%��ȡ
        v = mfcc(s1, fs1);%��ȡ��������
        a= vqlbg(v, k); %����
        data_matrix=[data_matrix,a(:)];
        T_train=[T_train,i+1];
    end
end

 %����������ݣ�����ȡ����
for i=0:9
    for j=0:9
        s = sprintf('voice_data/test/%i0%i.wav',i,j);
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
s = sprintf('voice_data/%i.wav',2); %�Ķ�·�� 2���ǵ�2����3���ǵ�3�����Լ�ѡ��һ������
[s1 fs1] = audioread(s);%��ȡ
v = mfcc(s1, fs1);%��ȡ��������
a= vqlbg(v, k); %����
a=a(:);
b=mapminmax('apply',a,settings);%��һ
YY=sim(net,b);
[maxi,ypred]=max(YY);
leibie = ypred-1  %��ʾ����ǩ

save('VoiceRecognition_2.0/neting.mat','settings','net'); 