% 基于LMS的自适应时延估计

close all; clear all; clc
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
y=zeros(1,M); %输出初始化
e=zeros(1,M);
h=zeros(1,2*N+1); 
for n=N:M-N-1
    x1=x(n-N+1:n+N+1);
    y(n)=h*x1';                   %计算n时刻的输出
    e(n)=d(n)-y(n);               %计算n时刻的误差
    h=h+delta*e(n)*x1;            %调整滤波器的系数
    hh(n,:)=h;
end
figure(1)
subplot(311);
plot(t1,d,'r',t1,x,'b');
legend('参考信号','输入信号'); grid;
title('s信号经过一段延时后的信号');
subplot(312);
plot(t1,d,'r',t1,y,'b'); 
legend('参考信号','输出信号'); grid;
title('经自适应滤波器处理后的信号');
subplot(313);
plot(t1,e); grid;
title('误差信号');

for k=N : M-N-1
    h=hh(k,:);
    [hmax,hloc]=max(h);
    Hmax(k)=hmax; Hloc(k)=hloc;
end
HL=length(Hmax);

[HHM,HHL]=max(Hmax);
figure(2);
plot(hh(HHL,:));
delay=(Hloc(HHL)-N-1);  %延迟的样点数
delaytime=delay/fs;     %计算出延迟的时间
fprintf('延迟样点数=%4d   延迟时间=%5.6f(秒)\n',delay,delaytime);
