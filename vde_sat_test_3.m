clc;
close all;
clear all;

% Data:cpe,cpa
% 讀取 .mat 檔案
data_cpa = load('CPA_SF16_NS16_BL261_compatible.mat');
data_cpe = load('CPE_SF16_NS16_BL261.mat');
% 取得變數名稱（這裡變數名稱是 'CPA_SF16_NS16_BL261'）
field_name_cpa = fieldnames(data_cpa);
array_data_cpa = data_cpa.(field_name_cpa{1});
% 取得變數名稱（這裡變數名稱是 'CPE_SF16_NS16_BL261'）
field_name_cpe = fieldnames(data_cpe);
array_data_cpe = data_cpe.(field_name_cpe{1});
%
BL = 261; % X(n)長度
SF = 16;  % 碼片速率
NS = 16;  % 過採樣速率
%
SL = SF*NS;
BS = BL*SL; % 單一訊號擴展長度 261*(16*16) = 66816
TL = BS/2;
%
unit = [0 ; 1]; % QPSK訊號
x =  repmat(unit, 1, BL);  % x[n]     
y = zeros(1,BS);     % 輸出陣
%
q = gray_to_quadrant(x);
iq_values = qpsk_to_iq(q);
%
for k = 0:BS-1
    n = floor(k/SL);
    m = mod(k,SL);

    if m < SL/2
        %
        la = mod(m+n*SL/2 , TL);
        if n == 0
            pa = 0 ;
        else
            pa = mod( q(n +1)-q(n-1 +1), 4) ;
        end
        y(k +1) = iq_values(n +1) * exp( i*array_data_cpa(la +1,pa +1) );
    else
        %
        le = mod(m+(n-1)*SL/2 , TL) ; 
        if n < BL-1
            pe = mod( q(n+1 +1)-q(n +1), 4);
        else
            pe = 0 ;
        end
        y(k +1) = iq_values(n +1) * exp(array_data_cpe(le +1,pe +1)) ;
    end

end
disp(y);
