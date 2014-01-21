function [RMSE GLOBAL LOCAL] = QuartileScaling(EC,OFFSET,PASS)

RMSE = zeros(1,PASS);
GLOBAL = 0.5*(EC - prctile(EC,25)) / (prctile(EC,75) - prctile(EC,25)) + 0.25;
GLOBAL(GLOBAL > 1) = 1;
GLOBAL(GLOBAL < 0) = 0;

for limit = 1:PASS
    EC_A = prctile(EC(OFFSET:OFFSET+limit),25);
    EC_B = prctile(EC(OFFSET:OFFSET+limit),75);
    LOCAL = 0.5*(EC - EC_A) / (EC_B - EC_A) + 0.25;
    LOCAL(LOCAL > 1) = 1;
    LOCAL(LOCAL < 0) = 0;
    RMSE(limit) = sqrt(nanmean((LOCAL-GLOBAL).^2));
end

% UNCOMMENT TO DISPLAY RESULTS
% plot(RMSE);
% disp(min(GLOBAL));
% disp(max(GLOBAL));

end

