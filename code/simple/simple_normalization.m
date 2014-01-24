function [RMSE GLOBAL LOCAL] = MedianScaling(EC,OFFSET,PASS)

GLOBAL = (EC) / (2*median(EC));
GLOBAL(GLOBAL > 1) = 1;
GLOBAL(GLOBAL < 0) = 0;

EC_M = median(EC(OFFSET:OFFSET+PASS));
LOCAL = (EC) / (2*EC_M);
LOCAL(LOCAL > 1) = 1;
LOCAL(LOCAL < 0) = 0;
RMSE = sqrt(nanmean((LOCAL-GLOBAL).^2));

% UNCOMMENT TO DISPLAY RESULTS
% plot(RMSE);
% disp(min(GLOBAL));
% disp(max(GLOBAL));

end