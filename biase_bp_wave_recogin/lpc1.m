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
    a= lpc(s',14);%����lpc����
    m(i,:)=a;
    end
     %���Թ���
    leng=size(m,1);
    xi=linspace(1,leng,20);
    for i=1:size(xi,1)                                           
    c1= m(i,:);
    c2=interp1((1:1:size(m,2)),c1',xi,'pchip');
    b(i,:)=c2;
    end 
   
    c=b;