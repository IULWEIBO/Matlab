function P = SampleCreate(type,N,UnitLength)
% P = SampleCreate(type,N,UnitLength)
% ��Ƶ�ļ�����ʽ��.\type\Ex\rank.wav����type:Ϊ�ַ���S����sample��T������ԣ�Ex������Ƶ����(1��2��3...)��rankΪ�������ļ������
% type��Ϊ�ַ���S/T
% N����ʾʹ�ö��ٸ���Ƶ����
% UnitLength��һ�����س��ȣ���λms
% mfccϵ�����������ķ�ʽ�洢��������,ÿ��mfccϵ����������Ϊ12
% ��������ѵ�����߷��������P
P=[];
step = 2;           %��Ƶ���ݵĲ���
start= 0;
%rank=1;
for rank=1:N      %˳��1\1.wav 2\1.wav ... 1\2.wav 2\2.wav ...
    for Ex=1:step:7
        filename= ['/Users/himin/Documents/MATLAB/Other/chengxu/' type '/' num2str(Ex) '/' num2str(rank) '.wav']
        [xVoice freq]  = wavread(filename);        % xVoice������ʱ�洢�������Ƶ�ļ�
        xMfcc   = mfcc(xVoice,fix(UnitLength*freq/1000),freq);             % ���mfccϵ������xMfcc���ڴ洢δ�������xMfcc���󡪡�������֡
        reMfcc  = MfccProcess(xMfcc);       % reMfcc���ڱ��洦��õ�mfcc������
        if eps>start
            P   = reMfcc;
        else
            P   = [P reMfcc];
        end
        start   = 1;
    end
end