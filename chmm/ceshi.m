x = wavread('G:\��ҵ�������\record\my.wav');
[x1 x2] = vad(x);
m = mfcc(x);
m = m(x1-2:x2-2,:);
for k=1:14
    pout(k) = viterbi(hmm{k},m);
end
[d,n] = max(pout);
switch n
    case 1
        disp('ʶ����Ϊ��������"0"');
    case 2
        disp('ʶ����Ϊ��������"1"');        
    case 3
        disp('ʶ����Ϊ��������"2"');        
    case 4
        disp('ʶ����Ϊ��������"3"');
    case 5
        disp('ʶ����Ϊ��������"4"');
    case 6
        disp('ʶ����Ϊ��������"5"');
    case 7
        disp('ʶ����Ϊ��������"6"');
    case 8
        disp('ʶ����Ϊ��������"7"');
     case 9
        disp('ʶ����Ϊ��������"8"');
     case 10
        disp('ʶ����Ϊ��������"9"');
     case 11
        disp('ʶ����Ϊ����"֣"');  
     case 12
        disp('ʶ����Ϊ����"��"');
     case 13
        disp('ʶ����Ϊ����"��"');
     case 14
        disp('ʶ����Ϊ����"ѧ"');  
     otherwise
        disp('δ֪����');
end
