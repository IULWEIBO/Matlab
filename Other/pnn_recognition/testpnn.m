
%��������ȷ��,�����������������
clc;
clear;

t1=cputime;
num=10;

disp('���ڼ�������ʶ��PNNģ��...');

for i=1:num
	fname = sprintf('%d.wav',i-1);
	x = wavread(fname);
	%[x1 x2] = vad(x);   %�˵���
	m = mfcc(x);
	%m = m(x1-2:x2-2,:);
    l=length(m(:,1));
	ref(i).mfcc = m';
    ref(i).tc=i*ones(1,l);
end

p=ref(1).mfcc;
tc=ref(1).tc;
for i=1:num-1
    p=[p,ref(i+1).mfcc];
    tc=[tc,ref(i+1).tc];
end
t=ind2vec(tc);

spread=5;
net=newpnn(p,t,spread);


disp('���ڼ����������ʶ��Ľ��...');
s=0;
for i=1:num
	fname = sprintf('%d.wav',i-1);
	x = wavread(fname);
	%[x1 x2] = vad(x);
	m = mfcc(x);
	%m = m(x1-2:x2-2,:);
	y=sim(net, m');
    test(i).yc=vec2ind(y);
     test(i).num=0;
     for j=1:length(test(i).yc)
          if  test(i).yc(j)==i
               test(i).num= test(i).num+1;
         end
     end
     fname = sprintf('recognition correct rate for each digit %d',i-1);
     disp(fname);
    t=test(i).num/length(test(i).yc) ; %recognition correct rate for each digit
     s=s+t;
     disp(test(i).yc);
     disp(t);
    figure 
    hist(test(i).yc);
end
disp('average correct rate:s=');
s=s/10    %average correct rate

t2=cputime-t1

%%%%%%%ģ��ƥ�����,dtw
% close all;
% disp('���ڽ���ģ��ƥ��...')
% dist = zeros(10,10);
% for i=1:10
% for j=1:10
% 	dist(i,j) = dtw(test(i).mfcc, ref(j).mfcc);
% end
% end
% 
% disp('���ڼ���ƥ����...')
% for i=1:10
% 	[d,j] = min(dist(i,:));
% 	fprintf('����ģ�� %d ��ʶ����Ϊ��%d\n', i, j);
% end