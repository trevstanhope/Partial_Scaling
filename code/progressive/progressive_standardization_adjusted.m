function [RMSE ERROR GLOBAL LOCAL] = progressive_standardization_adjusted(EC, OFFSET, LIMIT)

LOCAL = zeros(1, LIMIT);
RANGE = EC(OFFSET:OFFSET+LIMIT-1);
GLOBAL = (RANGE - mean(RANGE))/(6*std(RANGE)) + 0.5;
GLOBAL(GLOBAL > 1) = 1;
GLOBAL(GLOBAL < 0) = 0;

for limit = 1:LIMIT
    EC_M = mean(EC(OFFSET:OFFSET+limit-1));
    EC_S = std(EC(OFFSET:OFFSET+limit-1));
    LOCAL(limit) = (EC(OFFSET+limit-1) - EC_M)/(6*EC_S) + 0.5;
    LOCAL(LOCAL > 1) = 1;
    LOCAL(LOCAL < 0) = 0;
end

ERROR = abs(LOCAL - GLOBAL);
RMSE = sqrt(nanmean((ERROR).^2));

% UNCOMMENT TO DISPLAY RESULTS
%plot(ERROR);
%fprintf('RMSE is: %d\n', RMSE);

end

