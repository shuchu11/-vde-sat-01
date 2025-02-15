function q = gray_to_quadrant(bits)
    % bits 是 2×N 矩陣，每列是 QPSK 兩位元 (00, 01, 10, 11)
    q = zeros(1, size(bits,2)); % 預先分配象限索引
    
    for i = 1:size(bits,2)
        if isequal(bits(:,i), [1;1])              % isequal()?????
            q(i) = 0; % 11 -> 第 0 象限
        elseif isequal(bits(:,i), [0;1])
            q(i) = 1; % 01 -> 第 1 象限
        elseif isequal(bits(:,i), [0;0])
            q(i) = 2; % 00 -> 第 2 象限
        elseif isequal(bits(:,i), [1;0])
            q(i) = 3; % 10 -> 第 3 象限
        end
    end
end
