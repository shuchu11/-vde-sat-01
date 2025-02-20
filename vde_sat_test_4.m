clc;
close all;
clear all;
% % 1. 讀取 cpe.mat , cpa.mat 檔案
% % 2. 參數值、輸入信號
% % 3. 根據公式計算y(n)
% % 4. 計算功率頻譜
% % 5. 繪製功率頻譜

% 1. 讀取 cpe.mat , cpa.mat 檔案
data_cpa = load('CPA_SF16_NS16_BL261.mat');
data_cpe = load('CPE_SF16_NS16_BL261.mat');
% 取得變數名稱（這裡變數名稱是 'CPA_SF16_NS16_BL261'）
field_name_cpa = fieldnames(data_cpa);
array_data_cpa = data_cpa.(field_name_cpa{1});
% 取得變數名稱（這裡變數名稱是 'CPE_SF16_NS16_BL261'）
field_name_cpe = fieldnames(data_cpe);
array_data_cpe = data_cpe.(field_name_cpe{1});
% 2. 參數值、輸入信號
BL = 261; % X(n)長度
SF = 16;  % 擴散係數
NS = 16;  % 過採樣速率
fs = 4*36e3; % 晶片率 36 kchip/s (文章提到的) ; 過採樣係數 k = 4
% 
SL = SF*NS; % 單一訊號擴展長度 16*16 = 256
BS = BL*SL; % 全部訊號擴展長度 261*(16*16) = 66816
TL = BS/2;  % 總輸出長度的一半 33408
% 製作輸入訊號
unit = [1 ; 1]; % QPSK訊號 0101....            %(測試用)
x =  repmat(unit, 1, BL);  % x[n]              %(測試用)
% x = randi([0 1], 2, BL); % 產生隨機 0/1         %(測試用)
y = zeros(1,BS);     % 輸出陣列
%
q = gray_to_quadrant(x);  % 將QPSK值映射到對應象限
iq_values = qpsk_to_iq(q);% 將QPSK值映射到對應IQ值
% 3.根據公式計算y(n)
for k = 0:BS-1
    n = floor(k/SL);
    m = mod(k,SL);

    if m < SL/2
        % 計算索引值la
        la = mod(m+n*SL/2 , TL);
        % 計算索引值pa
        if n == 0
            pa = 0 ;
        else
            pa = mod( q(n +1)-q(n-1 +1), 4) ;
        end
        y(k +1) = iq_values(n +1) * exp( i*array_data_cpa(la +1,pa +1) );
    else
        % 計算索引值le
        le = mod(m+(n-1)*SL/2 , TL) ; 
        % 計算索引值pe
        if n < BL-1
            pe = mod( q(n+1 +1)-q(n +1), 4);
        else
            pe = 0 ;
        end
        y(k +1) = iq_values(n +1) * exp( i*array_data_cpe(le +1,pe +1) );
    end
end

% 4. 計算功率頻譜
[Pxx, f] = pwelch(y, hamming(2048), 1, [], fs, 'centered');

% 5. 繪製功率頻譜
figure;
plot(f/1e3, 10*log10(Pxx/Pxx(1024)), 'b', 'LineWidth', 3);
xlabel('Frequency (kHz)');
ylabel('Power Spectrum (dB)');
title('Power Spectral Density of Spread Spectrum (SF=16)');
grid on;
xlim([-100 100]); % 限制頻率範圍
ylim([-90 0]); % 限制功率範圍



