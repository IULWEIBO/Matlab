%	by lkk@mails.tsinghua.edu.cn

function [lpc_number] = lpc(frames,rank);

%   ���룺
%      frames       ����֡ 
%      rank         lpc���� 
%   �����
%       lpc_number  lpcϵ������rank��n������
[windowsize, numframes] = size(frames);


lpc_number = [];


% ������ط�����lpcϵ��
for nFrame = 1:numframes
    R = zeros(rank+1,1);
    alpha = zeros(rank,rank);
    E = zeros(rank+1,1);
    k = zeros(rank,1);
    for i = 1:rank+1
        R(i) = sum(frames(i:windowsize,nFrame).*frames(1:windowsize-i+1,nFrame));
    end
    
    E(1) = R(1);
    for i = 1:rank
        tmpSum = 0;
        for j = 1:i-1
            tmpSum = tmpSum + alpha(j,i-1)*R(i-j+1);
        end
        k(i) = (R(i+1) - tmpSum)/E(i);
        alpha(i,i) = k(i);
        for j = 1:i-1
            alpha(j,i) = alpha(j,i-1) - k(i)*alpha(i-j,i-1);
        end
        E(i+1) = (1-k(i)*k(i))*E(i);
    end
    
    % lpcϵ��
    lpc_number = [lpc_number,alpha(:,rank)];

end