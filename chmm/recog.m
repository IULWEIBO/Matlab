
  t1=cputime;
  tic;
s=0;
COUNT=14;
PERSON=10;
NUMBER=2;
filename={'chang','dang','feng','li','jiang','jin','shui','xin','zhao','zhou'};
file='G:\毕业论文相关\record\';


for i=1:COUNT
    for j=1:PERSON
        for m=1:NUMBER
            tempname=[file,filename{j},num2str(m+2),num2str('-'),num2str(i-1),'.wav'];
            recognize{i,j,m}=wavread(tempname);
        end      
    end
end

r=[];
 for j=1:size(recognize,3)
    r=[r recognize(:,:,j)];
 end

  L=size(r,2);
 for i =1:size(r,1)
% for i =1:3   
    h=0;
    for j=1:L
        m=[];
%         n=[];
        x=r{i,j};
        [x1 x2] = vad(x);
        m = mfcc(x);
%             n=lpcc(x);
%          fprintf('数字%d的第%d个样本出现问题\n',i-1,j);
        m = m(x1-2:x2-2,:);
%         n = n(x1-2:x2-2,:);
%          p = [m n];
        for k=1:14
            pout(k) = viterbi(hmm{k},m);
        end
        [d,n] = max(pout);
        if(i==n)
            h=h+1;
        end
    end
    rate=100*h/L;
    fprintf('第%d个词的识别率为: %6.2f %%\n',i,rate);
    s=s+rate;
 end
mean=s/14;
 t2=cputime-t1;

% toc;
 fprintf('runtime = %6.2f,平均识别率为:%6.2f %%.\n',t2,mean);
% x = wavread('G:\毕业论文相关\record\xin1-8.wav');
% [x1 x2] = vad(x);
% m = mfcc(x);
% m = m(x1-2:x2-2,:);
% for j = 1:14
%     pout(j) = viterbi(hmm{j},m);
% end
% 
% [d,n] = max(pout);
% fprintf('识别为%d\n',n-1);
% x = wavread('G:\毕业论文相关\record\chang1-5.wav');
% [x1 x2] = vad(x);
% m = mfcc(x);
% for i=1:size(m,2)
%     sum(i)=0;
%     for j=1:size(m,1)
%         sum(i)=sum(i)+m(j,i);
%     end
% end
% sum=abs(sum)/24;
% figure(1)
% subplot(3,1,1)
% plot(m(:,1))
% axis([0 100 -10 20])
% xlabel('数字5的第一维MFCC系数');
% subplot(3,1,2)
% plot(m(:,2))
% axis([0 100 -10 20])
% xlabel('数字5的第二维MFCC系数');
% subplot(3,1,3)
% plot(m)
% axis([0 100 -30 30])
% xlabel('数字5的完整的24维MFCC系数');
% figure(2)
% bar(sum)
% axis([1 length(sum) 0 25])
