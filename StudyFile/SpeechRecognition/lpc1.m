  %������ Ԥ���� ��֡����ȡ��������
   function c = plc1(x)
    % Ԥ�����˲���
    w=double(x);
    w=filter([1 -0.9375],1,w);  
    
    % �����źŷ�֡
    w=enframe(w,256,128);
    
    % ����ÿ֡��LPC����
    for i=1:size(w,1)                                           
    y = w(i,:);
    s = y' .* hamming(256);
    a= lpc(s,14);%����lpc����
    end
    
    c=a;