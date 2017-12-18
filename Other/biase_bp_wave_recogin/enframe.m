function f=enframe(x,win,inc)
%ENFRAME split signal up into (overlapping) frames: one per row. F=(X,WIN,INC)
%
%	F = ENFRAME(X,LEN) splits the vector X up into
%	frames. Each frame is of length LEN and occupies
%	one row of the output matrix. The last few frames of X
%	will be ignored if its length is not divisible by LEN.
%	It is an error if X is shorter than LEN.
%
%	F = ENFRAME(X,LEN,INC) has frames beginning at increments of INC
%	The centre of frame I is X((I-1)*INC+(LEN+1)/2) for I=1,2,...
%	The number of frames is fix((length(X)-LEN+INC)/INC)
%
%	F = ENFRAME(X,WINDOW) or ENFRAME(X,WINDOW,INC) multiplies
%	each frame by WINDOW(:)

%	Copyright (C) Mike Brookes 1997
%
%      Last modified Tue May 12 13:42:01 1998
%
%   VOICEBOX home page: http://www.ee.ic.ac.uk/hp/staff/dmb/voicebox/voicebox.html
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This program is free software; you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation; either version 2 of the License, or
%   (at your option) any later version.
%
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You can obtain a copy of the GNU General Public License from
%   ftp://prep.ai.mit.edu/pub/gnu/COPYING-2.0 or by writing to
%   Free Software Foundation, Inc.,675 Mass Ave, Cambridge, MA 02139, USA.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nx=length(x);                     %ע��ͳ��x�ĵĳ��ȣ�xΪ�����źţ�winΪ��֡�ĳ��ȣ�inc��֡�ĵ�����
nwin=length(win);                 %ע��ͳ��win�ĵĳ��ȣ�
if (nwin == 1)
   len = win;
else
   len = nwin;
end
if (nargin < 3)                   %ע�����nargin����ķ�ΧС��3��ִ����һ����
   inc = len;
end                               %ע������������if�൱�ڼӴ��������ضϹ����У��õ�һ֡һ֡���źţ�
nf = fix((nx-len+inc)/inc);  %ȷ��֡��
f=zeros(nf,len);                  %ע���ó�nf x len �׵�ȫ��������ڴ洢�õ���֡�źţ�
indf= inc*(0:(nf-1)).';           %ע���ó���֡�ĵ�����
inds = (1:len);                   %ע��indsȡ1��len�Ĳ������֣� 
f(:) = x(indf(:,ones(1,len))+inds(ones(nf,1),:));    %ע����������������ǣ�
if (nwin > 1)
    w = win(:)';                  %ע��win��ȫ��Ԫ��ת�ø���w��
    f = f .* w(ones(nf,1),:);     %ע����ones(nf,1���ó�ȫ1�ľ��󣬵�������ô�����ʽ�ӵõ���֡�ģ�
end                               %ע�������֡���㷨��û��ȫ����⣬����ķ�֡����һ�����������źŽ��л����ض�
                                  %ע��

