function [RMSE GLOBAL LOCAL] = MedianScaling(EC,OFFSET,PASS)

RMSE = zeros(1,PASS);
GLOBAL = (EC) / (2*median(EC));
GLOBAL(GLOBAL > 1) = 1;
GLOBAL(GLOBAL < 0) = 0;

for limit = 1:PASS
    EC_M = median(EC(OFFSET:OFFSET+limit));
    LOCAL = (EC) / (2*EC_M);
    LOCAL(LOCAL > 1) = 1;
    LOCAL(LOCAL < 0) = 0;
    RMSE(limit) = sqrt(nanmean((LOCAL-GLOBAL).^2));
end

% UNCOMMENT TO DISPLAY RESULTS
% plot(RMSE);
% disp(min(GLOBAL));
% disp(max(GLOBAL));

end

