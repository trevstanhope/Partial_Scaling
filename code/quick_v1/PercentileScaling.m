function [RMSE GLOBAL LOCAL] = PercentileScaling(EC,OFFSET,PASS)

RMSE = zeros(1,PASS);
GLOBAL = (EC - min(EC)) / (max(EC) - min(EC));
GLOBAL(GLOBAL > 1) = 1;
GLOBAL(GLOBAL < 0) = 0;

for limit = 1:PASS
    EC_A = min(EC(OFFSET:OFFSET+limit));
    EC_B = max(EC(OFFSET:OFFSET+limit));
    P_A = round2(invprctile(EC,EC_A), 5)/100;
    P_B = round2(invprctile(EC,EC_B), 5)/100;
    LOCAL = (P_B - P_A)*(EC - EC_A) / (EC_B - EC_A) + P_A;
    LOCAL(LOCAL > 1) = 1;
    LOCAL(LOCAL < 0) = 0;
    RMSE(limit) = sqrt(nanmean((LOCAL-GLOBAL).^2));
end

% UNCOMMENT TO DISPLAY RESULTS
% plot(RMSE);
% disp(min(GLOBAL));
% disp(max(GLOBAL));

end