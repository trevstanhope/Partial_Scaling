function [RMSE GLOBAL LOCAL] = StandardScaling(EC,OFFSET,PASS)

RMSE = zeros(1,PASS);
GLOBAL = (EC - mean(EC))/std(EC);
GLOBAL(GLOBAL > 1) = 1;
GLOBAL(GLOBAL < 0) = 0;

for limit = 1:PASS
    EC_M = mean(EC(OFFSET:OFFSET+limit));
    EC_S = std(EC(OFFSET:OFFSET+limit));
    LOCAL = (EC - EC_M)/(EC_S);
    LOCAL(LOCAL > 1) = 1;
    LOCAL(LOCAL < 0) = 0;
    RMSE(limit) = sqrt(nanmean((LOCAL-GLOBAL).^2));
end

% UNCOMMENT TO DISPLAY RESULTS
% plot(RMSE);
% disp(min(GLOBAL));
% disp(max(GLOBAL));

end
