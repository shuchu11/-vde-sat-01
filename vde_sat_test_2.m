clc;
close all;
clear all;

% Data:cpe,cpa
% 讀取 .mat 檔案
data_cpa = load('CPA_SF16_NS16_BL261.mat');
data_cpe = load('CPE_SF16_NS16_BL261.mat');
% 取得變數名稱（這裡變數名稱是 'CPA_SF16_NS16_BL261'）
field_name_cpa = fieldnames(data_cpa);
array_data_cpa = data.(field_name_cpa{1});
% 取得變數名稱（這裡變數名稱是 'CPE_SF16_NS16_BL261'）
field_name_cpe = fieldnames(data_cpe);
array_data_cpe = data.(field_name_cpe{1});
%
BL = 261; % X(n)長度
SF = 16;  % 碼片速率
NS = 16;  % 過採樣速率
%
SL = BF*NS;
BS = BL*SL; % 單一訊號擴展數
TL = BS/2;
%
unit = [0 1]; % QPSK訊號
Xn =  repmat(unit, 1, BL);  % x[n]size: 261*2 (因為一個訊號有2bits)
yn = zeros(1,BS*2);     % 輸出陣列大小同X[n]
for k = 1:BS
    n = floor(k/SL);
    m = mod(1,SL);

    if m < SL/2
        %
        la = mod(m+(n-1)*SL/2 , TL);
        if n == 0
            pa = 0;
        else
            pa = mod( q(n)-q(n-1), 4);
        end
        yn(n) = x(n) * array_data_cpa(la,pa);
    else
        %
        le = mod(m+n*SL/2 , TL); 
        if n < BL-1
            pe = mod( q(n+1)-q(n), 4);
        else
            pe = 0;
        end
        yn(n) = x(n) * array_data_cpa(le,pe);
    end

    
end

