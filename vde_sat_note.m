%% 重複 [0 1] 陣列，以產生 [0 1 0 1 0 1]
A = [0 1];
B = repmat(A, 1, 3);  % 重複 A 三次
disp(B);

%% 在一個陣列後插入另一個陣列或元素
A = [1 2 3];
B = [A 4];  % 在 A 後插入 4
disp(B);

%
A = [1 2 3];
C = [4 5 6];
B = [A C];  % 在 A 後插入 C
disp(B);

%% 載入 .mat 檔案並讀取指定位置的元素 (1,2)
% 讀取 .mat 檔案
data = load('CPA_SF16_NS16_BL261.mat');

% 取得變數名稱（這裡變數名稱是 'CPA_SF16_NS16_BL261'）
field_name = fieldnames(data);
array_data = data.(field_name{1});

% 提取 (1,2) 位置的元素
element_1_2 = array_data(1,2);

% 顯示結果
fprintf('陣列 (1,2) 位置的元素值為: %.4f\n', element_1_2);

%% 取餘數
A = mod(1,20)
%% 地板符號(朝負無窮大方向取整)
A = floor(1.3)






