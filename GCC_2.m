%% 广义互相关求时间延迟
% generalized cross correlation 
% TDOA 
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
subplot(211);
plot(t,x1,'r');
axis([-0.2 1.5 -6 6]);
hold on;
plot(t,x2,':');
axis([-0.2 1.5 -6 6]);
legend('x1信号', 'x2信号');
xlabel('时间/s');ylabel('x1(t) x2(t)');
title('原始信号');grid on;
hold off
%% 互相关函数 1 
X1=fft(x1,2*N-1);
X2=fft(x2,2*N-1);
Sxy=X1.*conj(X2);
Cxy=fftshift(ifft(Sxy));
%Cxy=fftshift(real(ifft(Sxy)));
subplot(212);
t1=(0:2*N-2)/Fs;                        %注意
plot(t1,Cxy,'b');
title('互相关函数');xlabel('时间/s');ylabel('Rx1x2(t)');grid on
[max,location]=max(Cxy);%求出最大值max,及最大值所在的位置（第几行）location;
%d=location-N/2-1        %算出延迟了几个点
d=location-N
Delay=d/Fs;              %求得时间延迟

%% 互相关函数 2
Cxy2=xcorr(x1,x2);    %Cross-correlation of the signal from-130 to 130 
%dd=find(Cxy2==max(Cxy2))-N     
[max1,location1]=max(Cxy2);
d2=location1-N