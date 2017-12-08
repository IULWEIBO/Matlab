Time1=cputime;
CM=[];

%-----------读语音数据-------------
COUNT=10;
PERSON=4;
filename={'My-','Lily-','Liang-','My1-'};

for i=1:COUNT
    for j=1:PERSON
        tempname=[filename{j},num2str(i-1),'.wav'];
        [signal,fs]=wavread(tempname);
         %-----------端点检测-------------
        i=1;
    while signal(i+1)-signal(i)<0.014
        i=i+1;
      end
        j=length(signal); 
    while signal(j-1)-signal(j)<0.014   
        j=j-1;
    end
    
    signal=signal(i:j);
    
    %-----------预加重-------------
 signal=double(signal);
  signal= filter([1 -0.9375],1,signal);
  %------------------------------

  %-------------求美尔倒谱系数-------------
  %  [x1 x2] = vad(signal);
    C=melcepst(signal,fs,'m',16,24,256,128,0,0.5);
  %  C = C(x1-2:x2-2,:);
    figure(99)
    plot(C)
    %C=C(:,1);
    C=C';
    %将每个数字得倒谱系数存为一个16*n的矩阵，用作神经网络输入
    CM=cat(2,CM,C);
  %------------------------------
    end
end


%-----------神经网络部分-------------

%对美尔倒谱系数做适当值提升
X=CM;
X=double(X);%化为双精度才能参与运算
[m,n]=size(X);%读矩阵的尺寸
P=zeros(16,10);%计算欧氏距离时？
Q=zeros(1,10);%计算欧氏距离时？

%神经网络初始化
N=16; %定义输入神经元个数
M=10;   %定义输出神经元个数？
%W=20*rand(16,7)-10;   %权值的初始化？
W=zeros(N,M);
for i=1:10
  W(:,i)=X(:,i*9);
end
T1=n;%学习样本次数
T2=200;%训练次数
%权值调整
for(t=1:T2) %开始训练，从1到T2
  stu=0.5*exp(-t/T2);%定义学习函数
  a=6.3*exp(-t/T2);
  for(T=1:T1) %开始取输入图像矢量
    NE=-2.1+8.4*exp(-T/T1); %定义邻域大小函数
    NE=round(NE);
    %计算邻域半径
    if(rem(NE,2)==0)
        R=NE/2;
    else
        R=(NE-1)/2;
    end
    %找出最小欧氏距离
    for(j=1:M)%？
        P(:,j)=(X(:,T)-W(:,j)).^2;%计算欧氏距离
        Q(1,j)=sum(P(:,j)); %欧氏距离和赋予新的矩阵
        [minQ,I]=min(Q);%找出最小数的下标,等同于输出矢量的下标
    end
    x0=I; %最小距离下标赋予x0
    %在邻域内调整权值
    for(j=I-R:I+R)
        if j<1
          j=j+M;
        end
        if j>M
          j=j-M;
        end
        x=j;
        stu_f=(1/(sqrt(2*pi)*a))*exp(-(x-x0).^2/(2*a.^2));%定义学习加权邻域函数
        W(:,j)=W(:,j)+stu*stu_f*(X(:,T)-W(:,j));
    end
  end
end
%save codebookbeeline W; %码书保存
CM;
figure(1)
imshow(W,[]);
save W;
%测试
for(i=1:T1)
  for(j=1:M)
    P(:,j)=(X(:,i)-W(:,j)).^2;%计算欧氏距离
    Q(1,j)=sum(P(:,j)); %欧氏距离和赋予新的矩阵
    [minQ,I]=min(Q);%找出最小数的下标,等同于输出矢量的下标
    s(i)=I;
  end
end
