clear;
x1=wavread('c1.wav');
%soundview('traffic69.wav');
x2=wavread('c2.wav');
x3=wavread('s1.wav');
x4=wavread('s2.wav');
x5=wavread('p1.wav');
x6=wavread('p2.wav');

x = {x1 x2};
y = {x3 x4};
z = {x5 x6};

samples={x y z};


    sample=[];
    for k=1:length(samples{3})
        sample(k).wave = samples{3}{k};
        sample(k).data=[];
    end
    
K = length(sample);

%������������
disp('���ڼ���������������')
for k=1:K
    if isfield(sample(k),'data')&~isempty(sample(k).data)
        continue;
    else
        sample(k).data = mfcc(sample(k).wave);  
    end
end

hmm = inithmm(sample,[3,3,3]);

loop =1;
    fprintf('\n��%d��ѵ��\n\n',loop)
    hmm = baum(hmm,sample);
    
    %�������������
    pout(loop) = 0;
    
for k=1:K
        
[m n]=viterbi(hmm,sample(k).data);
pout(loop) = pout(loop)+m;

end
    
    fprintf('�ܺ��������(log)=%d\n',pout(loop));

