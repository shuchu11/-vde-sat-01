clc;
close all;
clear all;

%
BL = 261; % X(n)長度
SF = 16;  % 碼片速率
NS = 16;  % 過採樣速率
%
SL = BF*NS;
BS = BL*SL;
TL = BS/2;
%
unit = [0 1];
Xn = [ repmat(unit, 1, 130) 0];  % x[n]size: 261
yn = zeros(1,BS);     % 1xBS 全 0 矩陣
for k = 1:BS
    m = mod(1,SL);
    n = floor(k/SL);
    le = mod(m+n*SL/2 , TL); 
    la = mod(m+(n-1)*SL/2 , TL);
    pe = 
    pa = 

end

