set(0,'defaultfigurecolor','w')  %  设置所有的绘图背景颜色为白色
%% method 1
clear all; clc; close all;
N=1024;  %长度
Fs=500;  %采样频率
n=0:N-1;
t=n/Fs;   %时间序列
a1=5;     %信号幅度
a2=5;
d=2;     %延迟点数
x1=a1*cos(2*pi*10*n/Fs);     %信号1
%x1=x1+randn(size(x1));      %加噪声
x2=a2*cos(2*pi*10*(n+d)/Fs); %信号2
%x2=x2+randn(size(x2));
figure(1)
plot(t,x1,'r');
axis([-0.2 1.5 -6 6]);
hold on;
plot(t,x2,':');
axis([-0.2 1.5 -6 6]);
legend('x1信号', 'x2信号');
xlabel('时间/s');ylabel('x1(t) x2(t)');
title('原始信号');grid on;
hold off
%% method 2
clear all; clc
L=5;           %取5个信号周期;L=6,7,8,9,10
fs=1000;       %抽样频率
t=(0:fs)/fs;   %抽样时间间隔
s1=sin(2*pi*L*t); %正弦信号 
m=length(t);  %m=1001

N=50;
delta=0.001;
J=10;
if J<0
    d=[zeros(1,-J) s1]; 
    x=[s1 zeros(1,-J)];
else
    x=[zeros(1,J) s1];
    d=[s1 zeros(1,J)];
end
M=length(x); 
t1=(0:M-1)/fs;
figure(2)
plot(t1,d,'r',t1,x,'b');
legend('参考信号','输入信号'); grid;
title('s信号经过一段延时后的信号');
%% method 3
clear all 
k=30; 
r=randn(1,2000); %noise 
r1=r(1:1000); 
r2=r(1001:2000); 
d=zeros(1,k); %the delay of the signal 
 
n=1:1000;  
s=10*sin(2*pi*500*(n+2)/10000)+0.1*10*sin(2*pi*500*(n+1)/10000)+0.1*sin(2*pi*500*n/10000); %主频500Hz，采样频率10KHz 
x1=s+r1; 
x=s+r2; 
x2=[randn(1,k) x(1:1000-k)] ;          %delay signal 
i=1:1000;
figure(3)
subplot(211) 
plot(i,x1) 
subplot(212) 
plot(i,x2(i)) 
%% method 4 
clc;clear all;

fs = 1000;%采样频率
fc = 0.2*fs ;%载波频率
t0=0;%起始时间
t1= 10;%终止时间
T = t1-t0;

%%%%%%%%%%%%%%%%%%参数设置%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fd1= 0.0625*fs;%码速率
fd2 = 0.0125*fs;
kesi = fd1;
delay1 = 50;
delay2 = 18;
t=[t0:1/fs:t1-1/fs];%信号持续时间
N=length(t);
data_x=sign(randn(1,fd1*t1)); %BPSK
for i=1:length(data_x)
    mod_x((i-1)*fs/fd1+1:i*fs/fd1)=data_x(i);%产生调制信号 
end
s1=  mod_x.*cos(2*pi*fc*t); %调制
s2 = [zeros(1,delay1),s1];
s2 = s2(1:N);
figure(4)
plot(t,s1,'r',t,s2,'b');
legend('参考信号','时延信号');
title('产生时延信号');