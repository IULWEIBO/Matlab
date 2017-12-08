close all
clear
clc
% [x]=wavread('�ޱ���.wav');
% [x]=wavread('G:\��ҵ�������\record\dang4-1.wav');
[x]=wavread('G:\voice\WN_clean.wav');
%���ȹ�һ����[-1,1]
x = double(x);
x = x / max(abs(x));

%��������
FrameLen = 256;
FrameInc = 80;

amp1 = 10;
amp2 = 2;


maxsilence =3; % 10*10ms = 30ms
minlen = 15; % 15*10ms = 150ms
status = 0;
count = 0;
silence = 0;


%�����ʱ����
amp = sum(abs(enframe(filter([1 -0.9375], 1, x), FrameLen, FrameInc)), 2);

%������������
amp1 = min(amp1, max(amp)/4);
amp2 = min(amp2, max(amp)/8);

%��ʼ�˵���
x1 = 0;
x2 = 0;
for n = 1:length(amp)
    goto = 0;
    switch status
        case {0,1}   % 0��������1�����ܿ�ʼ
            if amp(n)>amp1   %ȷ�Ž���������
                x1 = max(n-count-1,1)  %��㣬��ȷ�Ž���������εĵ��ȥ���ܴ��������ε�ʱ��ĵ㣬�õ���ʼ���������εĵ�
                status = 2;
                silence = 0;
                count = count+1;
            elseif amp(n)>amp2 %���ܴ���������
                    status = 1;
                    count = count+1;
                else  %û�н���������
                    status = 0;
                    count = 0;
                end
        case 2,   % 2��������
            if amp(n)>amp2   %������������
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
                   
count = count-silence/2
x2 = x1+count-1


subplot(211)
plot(x)
axis([1 length(x) -1 1])
ylabel('Speech');
title('�����ź�')
line([x1*FrameInc x1*FrameInc], [-1 1], 'Color', 'red');
line([x2*FrameInc x2*FrameInc], [-1 1], 'Color', 'red');

subplot(212)
plot(amp);
axis([1 length(amp) 0 max(amp)])
ylabel('Energy');
title('��ʱ����')
line([x1 x1], [min(amp),max(amp)], 'Color', 'red');
line([x2 x2], [min(amp),max(amp)], 'Color', 'red');