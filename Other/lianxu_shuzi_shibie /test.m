fs=11025;
disp('��ʼ���С�����');
for i=0:9
     fid=fopen(strcat('d:/data/',num2str(i),'size.txt'),'r');
     [d,count]=fscanf(fid,'%d');
     status=fclose(fid);
	 fid=fopen(strcat('d:/data/',num2str(i),'.txt'),'r');
     reff(i+1).mfcc=zeros(d,24);
     [X,count]=fscanf(fid,'%f ');
     for j=1:24
         reff(i+1).mfcc(:,j)=X((j-1)*d+1:j*d);
     end
%     test(i+1).mfcc=reff(i+1).mfcc;
end
disp('ģ���Ѽ���');
disp('׼��¼�������������ʼ��');
pause;
disp('¼����ʼ');
x=wavrecord(8*fs,fs,'double');
x=quzao(x);
disp('����¼��');
[x1 x2] = vad(x);
m = mfcc(x);
nu=11;
for i=1:nu
    testt(i).mfcc = m(x1(i)-2:x2(i)-2,:);
end

dist = zeros(nu,10);
for i=1:nu
for j=1:10
	dist(i,j) = dtw2(testt(i).mfcc, reff(j).mfcc);
end
end

disp('���ڼ���ƥ����...')
fprintf('ʶ����Ϊ��');
for i=1:nu
	[d,j] = min(dist(i,:));
	fprintf('%d', j-1);
end
