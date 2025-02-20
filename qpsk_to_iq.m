function iq_values = qpsk_to_iq(qpsk_symbols)
    % QPSK 對應的 IQ 值 (Gray 編碼)
    qpsk_map = containers.Map({0, 1, 2, 3}, ...
                              {exp(1i*(pi/4)), exp(1i*(-pi/4)), exp(1i*(pi*3/4)), exp(1i*(-pi*3/4))});
    
    % 初始化 IQ 值陣列
    iq_values = zeros(size(qpsk_symbols));
    
    % 轉換 QPSK 符號至 IQ 值
    for k = 1:length(qpsk_symbols)
        if isKey(qpsk_map, qpsk_symbols(k))
            iq_values(k) = qpsk_map(qpsk_symbols(k));
        else
            error('輸入的 QPSK 符號必須是 0, 1, 2, 或 3');
        end
    end
end

