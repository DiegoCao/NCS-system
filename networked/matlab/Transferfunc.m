clc;
clearvars;
%闭环系统传递函数建立
%输入倒立摆传递函数 G（e）=num/den
M=10;
%M=10;
m=2;
%m=1;
b=0.1;
%b=0;
c=0.1;
%c=0;
I=0.006;
%I=3;
g=10;
%l=0.3;
l=4;
%传递函数分子分母系数分母用F，分子用Z表示
F1=(I+m*l^2)*(M+m)+m^2*l^2;
F2=(I+m*l^2)*b+(M+m)*c;
F3=b*c-(M+m)*m*g*l;
F4=m*g*l*b;
Z1=m*l;
%传递函数
num=[Z1 0 0];
den=[F1 F2 F3 F4 0];
%num=[0.1804 1.39 2.185 0 0]
%den=[0.0204 0.2528 0.9881 2.244 0 0]
%理论计算得出Kd Ki Kp，以一种为例
Kp=-2*F3/Z1+1500;
Ki=5000;
Kd=2*F1*Ki/(Z1*Kp+F3)+0.1;
disp("Kp is");
disp(Kp);
disp("Kd is");
disp(Kd);
G=tf(num,den)
hnum=[Kd Kp Ki]
hden=[1 0]
H=tf(hnum,hden);
Gc=feedback(G,H)
p=eig(G)
pc=eig(Gc)
%求系统的特征根
p1=pole(G);%求系统的极点
r=roots(den);%求系统的特征方程的根
disp("Kp Ki Kd矩阵为");
% global KKP;
% global KKI;
% global KKD;
% KKP=Kp;
% KKI=Ki;
% KKD=Kd;
disp([Kp Ki Kd]);