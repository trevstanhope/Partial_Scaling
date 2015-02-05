%% Simple Quartile
function [RMSE GLOBAL LOCAL] = simple_quartile(EC,OFFSET,PASS)

GLOBAL = 0.5*(EC - prctile(EC,25)) / (prctile(EC,75) - prctile(EC,25)) + 0.25;
GLOBAL(GLOBAL > 1) = 1;
GLOBAL(GLOBAL < 0) = 0;

EC_A = prctile(EC(OFFSET:OFFSET+PASS),25);
EC_B = prctile(EC(OFFSET:OFFSET+PASS),75);
LOCAL = 0.5*(EC - EC_A) / (EC_B - EC_A) + 0.25;
LOCAL(LOCAL > 1) = 1;
LOCAL(LOCAL < 0) = 0;
RMSE = sqrt(nanmean((LOCAL-GLOBAL).^2));

% UNCOMMENT TO DISPLAY RESULTS
% plot(RMSE);
% disp(min(GLOBAL));
% disp(max(GLOBAL));

end

