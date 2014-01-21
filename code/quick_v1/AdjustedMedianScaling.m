function [RMSE GLOBAL LOCAL] = AdjustedMedianScaling(EC,OFFSET,PASS)

RMSE = zeros(1,PASS);
GLOBAL = (EC - min(EC)) / (2*median(EC) - min(EC));
GLOBAL(GLOBAL > 1) = 1;
GLOBAL(GLOBAL < 0) = 0;

for limit = 1:PASS
    EC_A = min(EC(OFFSET:OFFSET+limit));
    EC_M = median(EC(OFFSET:OFFSET+limit));
    LOCAL = (EC - EC_A) / (2*EC_M - EC_A);
    LOCAL(LOCAL > 1) = 1;
    LOCAL(LOCAL < 0) = 0;
    RMSE(limit) = sqrt(nanmean((LOCAL-GLOBAL).^2));
end

% UNCOMMENT TO DISPLAY RESULTS
% plot(RMSE);
% disp(min(GLOBAL));
% disp(max(GLOBAL));

end