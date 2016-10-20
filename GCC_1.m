% signal delay estimates using Cross-correlation function 
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
 
y=xcorr(x2,x1);    %Cross-correlation of the signal from-130 to 130 
x=find(y==max(y))-1000             %延迟 
i=1:1000; 
 
subplot(311) 
plot(i,x1) 
subplot(312) 
plot(i,x2(i)) 
k=1:1999; 
subplot(313) 
plot(k,y(k))