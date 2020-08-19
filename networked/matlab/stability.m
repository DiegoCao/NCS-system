%clc
%知传递函数分析脉冲响应
%num=[0.06 0 0];
%den=[0.0204 0.0724 -0.4016 0.0588 0];
clc
%闭环系统传递函数建立
%输入倒立摆传递函数 G（e）=num/den
%M=0.5;
M=0;
%m=0.2;
m=1;
%b=0.1;
b=0;
%c=0.1;
c=0;
%I=0.006;
I=0;
g=10;
%l=0.3;
l=3;
%传递函数分子分母系数分母用F，分子用Z表示
F1=(I+m*l^2)*(M+m)+m^2*l^2;
F2=(I+m*l^2)*b+(M+m)*c;
F3=b*c-(M+m)*m*g*l;
F4=m*g*l*b;
Z1=m*l;
%Transfer Function
num=[Z1 0 0];
den=[F1 F2 F3 F4 0];
G=tf(num,den)
%稳定性分析
p=eig(G);%求系统的特征根
p1=pole(G);%求系统的极点
r=roots(den);%求系统的特征方程的根
disp('系统极点')
disp(r)
a=find(real(r)>0);%查找特征方程跟实部大于0的值
b=length(a);
if b>0
    disp('系统不稳定');
else
    disp('系统稳定');
end