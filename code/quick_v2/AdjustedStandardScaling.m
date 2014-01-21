function [RMSE GLOBAL LOCAL] = AdjustedStandardScaling(EC,OFFSET,PASS)

GLOBAL = (EC - mean(EC))/(6*std(EC)) + 0.5;
GLOBAL(GLOBAL > 1) = 1;
GLOBAL(GLOBAL < 0) = 0;

EC_M = mean(EC(OFFSET:OFFSET+PASS));
EC_S = std(EC(OFFSET:OFFSET+PASS));
LOCAL = (EC - EC_M)/(6*EC_S) + 0.5;
LOCAL(LOCAL > 1) = 1;
LOCAL(LOCAL < 0) = 0;
RMSE = sqrt(nanmean((LOCAL-GLOBAL).^2));

% UNCOMMENT TO DISPLAY RESULTS
% plot(RMSE);
% disp(min(GLOBAL));
% disp(max(GLOBAL));

end
