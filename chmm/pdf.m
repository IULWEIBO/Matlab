function p = pdf(m,v,x)
%�����Ԫ��˹�ܶȺ���
%���룺
%m--��ֵ������SIZE*1
%v--����������SIZE*1
%x--����������SIZE*1
%�����
%p--�������
if(v~=0)
    p = (2*pi*prod(v))^-0.5*exp(-0.5*(x-m)./v*(x-m)');
else
    p = 0;
    fprintf('����Ϊ0\n');
end