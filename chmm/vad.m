function [x1,x2] = vad(x)

%���ȹ�һ����[-1,1]
x = double(x);
x = x/max(abs(x));

%��������
Len = 240;
Inc = 80;

amp1 = 10;
amp2 = 2;
zcr1 = 10;
zcr2 = 5;

maxsilence = 3; % 3*10ms = 30ms
minlen = 15;    %15*10ms = 150ms
status = 0;  %��ʾ��ǰ������״̬��0Ϊ������1Ϊ���ɶΣ�2Ϊ�����Σ�3Ϊ����
count = 0;   
silence = 0;

%���������
tmp1 = enframe(x(1:length(x)-1),Len,Inc);
tmp2 = enframe(x(2:length(x)),Len,Inc);
signs = (tmp1.*tmp2)<0;
diffs = (tmp1-tmp2)>0.02;
zcr = sum(signs.*diffs,2);

%�����ʱ����
amp = sum(abs(enframe(filter([1 -0.9375],1,x),Len,Inc)),2);   %ÿһ֡�Ķ�ʱ����

%������������
amp1 = min(amp1,max(amp)/4);
amp2 = min(amp2,max(amp)/8);

%��ʼ�˵���
x1 = 0;
x2 = 0;
for n = 1:length(zcr)
    goto = 0;
    switch status
        case {0,1}   % 0��������1�����ܿ�ʼ
            if amp(n)>amp1   %ȷ�Ž���������
                x1 = max(n-count-1,1);  %��㣬��ȷ�Ž���������εĵ��ȥ���ܴ��������ε�ʱ��ĵ㣬�õ���ʼ���������εĵ�
                status = 2;
                silence = 0;
                count = count+1;
            elseif amp(n)>amp2|zcr(n)>zcr2  %���ܴ���������
                    status = 1;
                    count = count+1;
                else  %û�н���������
                    status = 0;
                    count = 0;
                end
        case 2,   % 2��������
            if amp(n)>amp2|zcr(n)>zcr2   %������������
                    count = count+1;
                else
                    silence = silence+1;
                    if silence<maxsilence  %����������������δ����
                        count = count+1;
                    elseif count<minlen
                            status = 0;
                            silence = 0;
                            count = 0;
                        else
                            status = 3;
                        end
                    end
         case 3,  %��������
                 break;
         end
     end
                   
%count = count-silence/2;
x2 = x1+count-1;

% subplot(3,1,1)
% plot(x)
% axis([1 length(x) -1 1])
% ylabel('speech');
% line([x1*Inc x1*Inc],[-1,1],'Color','red');
% line([x2*Inc x2*Inc],[-1,1],'Color','blue');
% 
% subplot(3,1,2)
% plot(amp)
% axis([1 length(amp) 0 max(amp)])
% ylabel('Amp');
% line([x1 x1],[min(amp),max(amp)],'Color','red');
% line([x2 x2],[min(amp),max(amp)],'Color','blue');
% 
% subplot(3,1,3)
% plot(zcr)
% axis([1 length(zcr) 0 max(zcr)])
% ylabel('ZCR');
% line([x1 x1],[min(zcr),max(zcr)],'Color','red');
% line([x2 x2],[min(zcr),max(zcr)],'Color','blue');

