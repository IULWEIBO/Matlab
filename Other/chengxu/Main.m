%�������ʱ�����ޣ�����û�������������Ч�Լ��
N = 5;                      % NΪ��ȡÿ��������Ƶѵ�������ĸ���
M = 3;                      % MΪ��ȡÿ��������Ƶ���������ĸ���
UnitLength = 20;            % ��ʶ�����źŶ�ʱ�����ʱ������λΪms
TestMW = [ 1 2 3];          % �������������ݵı�ǣ��������ݰ������Ӧ1.wav��2.wav����
                            % 1�����������Ϊѵ��������2�����������ΪA�Ĳ���������3�����������ΪB�Ĳ�������
                            % һ��������ͬһ���˵�1��3��5����Ƶ���
%�������Ǳ��1��3��5
T1 = [1 0 0]'               % 1�����
T3 = [0 1 0]'               % 3�����
T5 = [0 0 1]'               % 5�����
Ttemp = [T1 T3 T5]          % һ�������Ԫ
T = Ttemp;
for i=1:N-1
    T = [T Ttemp];
end

PS  = SampleCreate('S',N,UnitLength);
PR1 = min(PS');
PR1 = PR1';
PR2 = max(PS');
PR2 = PR2';
PR  = [PR1 PR2];
if size(PS,1)==size(T,1)
    if size(T,2)==size(PS,2)
    %���λ��ƥ����ѵ��
        netBP = newff(PR,[30,10,3],{'tansig','tansig','tansig'},'trainbfg');        % ��������
        netBP.trainParam.epochs = 100;                                              % ����ѵ������
        %����trainbfgС��100
        [net tr] = train(netBP,PS,T);
        plotperf(tr);                                               % �ۿ�ѵ����¼
        Test = SampleCreate('T',M,UnitLength);                      % ���ɲ�������
        Y = sim(net,Test)                                           % �ۿ����
'OK'
    else
        'ά����ƥ��'
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�����ֱ���
figure(121);
hold on;
title('�ֱ���');
%axis tight;
xlabel('Ŀ��ֵ');
ylabel('�������');
imagesc([1:size(Y,2)],[1 3 5],abs(Y));
colormap(gray);
hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ʶ��������
%������׼���
Standard = Ttemp;
for j=1:M-1
    Standard = [Standard Ttemp];
end
delta = Standard-Y;                                                 %�����ֵ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ʹ�þ�����
deltaSqr = delta.*delta;                                            %��ƽ��
deltaSqrt = sqrt(sum(deltaSqr)/3);                                    %�������
figure(1);
plot(deltaSqrt);
hold on;
title('���������');
grid on;
for k=1:length(TestMW)
    for l=3*(k-1)+1:3*k                                             %��k��������
        switch(TestMW(k))                                           %ѡ�����ݵ���ʽ
            case 1
                sign = 'ko';
            case 2
                sign = 'r*';
            case 3
                sign = 'md';
            otherwise
                sign = 'y.';
        end
        plot(l,deltaSqrt(l),sign);                                    %�������ݵ�
    end
end
hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ʹ�þ���ֵ���
deltaOp  = abs(delta);                                              %�����ֵ
deltaOpS = sum(deltaOp)/3;                                           %������ֵ��
figure(2);
plot(deltaOpS);
hold on;
title('������ֵ��');                                               
grid on;
for k=1:length(TestMW)
    for l=3*(k-1)+1:3*k                                             %��k��������
        switch(TestMW(k))                                           %ѡ�����ݵ���ʽ
            case 1
                sign = 'ko';
            case 2
                sign = 'r*';
            case 3
                sign = 'md';
            otherwise
                sign = 'y.';
        end
        plot(l,deltaOpS(l),sign);                                    %�������ݵ�
    end
end
hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
