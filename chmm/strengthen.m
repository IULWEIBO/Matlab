%function y=strengthen(x)


%BarkС�����ֽ�
%x=wavread('E:\voice\matlabcode\myhmm\WN_clean.wav');
x=wavread('jin1-6.wav');
subplot(2,1,1);
plot(x);
axis([0 20000 -1 1]);
wptree=wpdec(x,7,'db5');
%��BarkС���ֽ���еĵ�����Ҷ���ϲ�
for k=47:62
wptree=wpjoin(wptree,k);
end
%��BarkС���ֽ���еĵ������Ҷ���ϲ�
for k=79:86
wptree=wpjoin(wptree,k);
end
for k=91:94
wptree=wpjoin(wptree,k);
end
%plot(wptree);
%�����ڵ㰴��Ӧ��ֵ���д���
sorh='n';%��ѡ��ֵ����
%-----------
%����7��ڵ�
%-----------
for i=0:31
c70(:,i+1)=wpcoef(wptree,[7 i]);
q70=median(abs(c70(:,i+1)));
arr70(i+1)=(q70/0.6745).*sqrt(2*log(442));
if(i>0)
c70(:,i+1)=wthresh(c70(:,i+1),sorh,arr70(i+1));
wptree=write(wptree,'data',[7 i],c70(:,i+1));%�޸Ľڵ�ϵ��ֵ
end
end
for i=48:55
c71(:,i-47)=wpcoef(wptree,[7 i]);
q71=median(abs(c71(:,i-47)));
arr71(i-47)=(q71/0.6745).*sqrt(2*log(442));
c71(:,i-47)=wthresh(c71(:,i-47),sorh,arr71(i-47));
wptree=write(wptree,'data',[7 i],c71(:,i-47));
%�޸Ľڵ�ϵ��ֵ
end
%-----------
%����6��ڵ�
%-----------
for j=16:23
c60(:,j-15)=wpcoef(wptree,[6 j]);
q60=median(abs(c60(:,j-15)));
arr60(j-15)=(q60/0.6745).*sqrt(2*log(876));
c60(:,j-15)=wthresh(c60(:,j-15),sorh,arr60(j-15));
wptree=write(wptree,'data',[6 j],c60(:,j-15));
%�޸Ľڵ�ϵ��ֵ
end
for j=28:31
c61(:,j-27)=wpcoef(wptree,[6 j]);
q61=median(abs(c61(:,j-27)));
arr61(j-27)=(q61/0.6745).*sqrt(2*log(876));
c61(:,j-27)=wthresh(c61(:,j-27),sorh,arr61(j-27));
wptree=write(wptree,'data',[6 j],c61(:,j-27));
%�޸Ľڵ�ϵ��ֵend
end
%-----------
%����5��ڵ�
%-----------
for k=16:31
c5(:,k-15)=wpcoef(wptree,[5 k]);
q5=median(abs(c5(:,k-15)));
arr5(k-15)=(q5/0.6745).*sqrt(2*log(1743));
c5(:,k-15)=wthresh(c5(:,k-15),sorh,arr5(k-15));
wptree=write(wptree,'data',[5 k],c5(:,k-15));%�޸Ľڵ�ϵ��ֵ
end
%�ؽ��ź�
y=wprec(wptree);
subplot(2,1,2);
plot(y);
axis([0 20000 -1 1]);
wavwrite(y,8000,'E:\voice\matlabcode\myhmm\WtDeSpeech.wav');
