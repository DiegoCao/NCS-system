# NCS-system
**For details of update data go to section:** 
[Update](https://github.com/DiegoCao/NCS-system/blob/master/Update%20Notes)

## Update on 8.17 
Create this library 以防我删掉数据后凉了。
先前10天已完成工作：
1. 建立模型并成功仿真
2. 分别将传递函数或Time-transient的model接入truetime中

现仍需解决问题：如何让倒立摆系统最终趋于稳定态。
## Update on 8.18

对倒立摆系统(cpcc)上的，最后Ti=0.60。

*然而现在这个没用了，最后通过控制Kp Ki Kd，且cpcc上的如果不加Kd不可能稳定*（8.24）

## Update on 8.19
PID 参数：
8.19
Kp=23.16; Kd=3.007; Ki=36.42.

## Update on 8.22
Number Coefficients: 
[0.1804 1.39 2.185 0 0]
Denominator Coefficients:
[0.0204 0.2528 0.9881 2.244 0 0]

## Update on 8.23
开始part3书写

## Update on 8.24
Using Theoretical calculation（劳斯判据），结合matlab代码理论计算Kp Ki Kd范围
先数据为
```matlab
clc
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
G=tf(num,den)
%理论计算得出Kd Ki Kp，以一种为例
Kp=-F3/Z1+100;
disp("Kp is");
disp(Kp);
Ki=100;
Kd=F1*Ki/(Z1*Kp+F3)+0.1;
disp("Kd is");
disp(Kd);
G=tf(num,den)
hnum=[Kd Kp Ki]
hden=[1 0]
H=tf(hnum,hden)
Gc=feedback(G,H)
p=eig(G)
pc=eig(Gc)
%求系统的特征根
p1=pole(G);%求系统的极点
r=roots(den);%求系统的特征方程的根
```
结合劳斯判据可使三阶系统a1 a2 a3 a0均为正数且a2a1>a3a0
计算出Kp Ki Kd范围（需固定三者中一个变量）
在调节3hKp后无果，需调节Ki值才能使得响应曲线更贴合。

## Update on 8.25
完成初稿部分书写
对于s3.png数据如下:
$[Kp Ki Kd]=[1240 1000 69.2]$

更新：对于s3new一组更好的数据：
```matlab
data.K =  1740; %kp
data.Ki = 3000;
data.Kd = 200;
```
物极必反，一旦Kd达到1000量级直接爆炸

## Update on 8.26
第二幅图参数更新
$[Kp Ki Kd]=[400 100 10]$
对应图
```matlab
data.K =  241; %kp
%data.Ki = 5000;
data.Ki = 100;
data.Kd = 46.4;
```
![](https://codimd.s3.shivering-isles.com/demo/uploads/upload_95c235030edd0e289b6307928b2b872b.png)
