Time1=cputime;
CM=[];

%-----------����������-------------
COUNT=10;
PERSON=4;
filename={'My-','Lily-','Liang-','My1-'};

for i=1:COUNT
    for j=1:PERSON
        tempname=[filename{j},num2str(i-1),'.wav'];
        [signal,fs]=wavread(tempname);
         %-----------�˵���-------------
        i=1;
    while signal(i+1)-signal(i)<0.014
        i=i+1;
      end
        j=length(signal); 
    while signal(j-1)-signal(j)<0.014   
        j=j-1;
    end
    
    signal=signal(i:j);
    
    %-----------Ԥ����-------------
 signal=double(signal);
  signal= filter([1 -0.9375],1,signal);
  %------------------------------

  %-------------����������ϵ��-------------
  %  [x1 x2] = vad(signal);
    C=melcepst(signal,fs,'m',16,24,256,128,0,0.5);
  %  C = C(x1-2:x2-2,:);
    figure(99)
    plot(C)
    %C=C(:,1);
    C=C';
    %��ÿ�����ֵõ���ϵ����Ϊһ��16*n�ľ�����������������
    CM=cat(2,CM,C);
  %------------------------------
    end
end


%-----------�����粿��-------------

%����������ϵ�����ʵ�ֵ����
X=CM;
X=double(X);%��Ϊ˫���Ȳ��ܲ�������
[m,n]=size(X);%������ĳߴ�
P=zeros(16,10);%����ŷ�Ͼ���ʱ��
Q=zeros(1,10);%����ŷ�Ͼ���ʱ��

%�������ʼ��
N=16; %����������Ԫ����
M=10;   %���������Ԫ������
%W=20*rand(16,7)-10;   %Ȩֵ�ĳ�ʼ����
W=zeros(N,M);
for i=1:10
  W(:,i)=X(:,i*9);
end
T1=n;%ѧϰ��������
T2=200;%ѵ������
%Ȩֵ����
for(t=1:T2) %��ʼѵ������1��T2
  stu=0.5*exp(-t/T2);%����ѧϰ����
  a=6.3*exp(-t/T2);
  for(T=1:T1) %��ʼȡ����ͼ��ʸ��
    NE=-2.1+8.4*exp(-T/T1); %���������С����
    NE=round(NE);
    %��������뾶
    if(rem(NE,2)==0)
        R=NE/2;
    else
        R=(NE-1)/2;
    end
    %�ҳ���Сŷ�Ͼ���
    for(j=1:M)%��
        P(:,j)=(X(:,T)-W(:,j)).^2;%����ŷ�Ͼ���
        Q(1,j)=sum(P(:,j)); %ŷ�Ͼ���͸����µľ���
        [minQ,I]=min(Q);%�ҳ���С�����±�,��ͬ�����ʸ�����±�
    end
    x0=I; %��С�����±긳��x0
    %�������ڵ���Ȩֵ
    for(j=I-R:I+R)
        if j<1
          j=j+M;
        end
        if j>M
          j=j-M;
        end
        x=j;
        stu_f=(1/(sqrt(2*pi)*a))*exp(-(x-x0).^2/(2*a.^2));%����ѧϰ��Ȩ������
        W(:,j)=W(:,j)+stu*stu_f*(X(:,T)-W(:,j));
    end
  end
end
%save codebookbeeline W; %���鱣��
CM;
figure(1)
imshow(W,[]);
save W;
%����
for(i=1:T1)
  for(j=1:M)
    P(:,j)=(X(:,i)-W(:,j)).^2;%����ŷ�Ͼ���
    Q(1,j)=sum(P(:,j)); %ŷ�Ͼ���͸����µľ���
    [minQ,I]=min(Q);%�ҳ���С�����±�,��ͬ�����ʸ�����±�
    s(i)=I;
  end
end