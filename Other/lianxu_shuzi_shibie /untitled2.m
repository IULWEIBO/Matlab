% [filename,pathname] =uigetfile('*.wav','ѡ�������ļ�');
% if isequal(filename,0) || isequal(pathname,0)
%     return;
% end
% str=[pathname filename];
[s1, fs1] = audioread('1234.wav');%��ȡ

[x1,x2] = vad(s1);

