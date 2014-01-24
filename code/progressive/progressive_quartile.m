function [RMSE ERROR GLOBAL LOCAL] = progressive_quartile(EC, OFFSET, LIMIT)

LOCAL = zeros(1, LIMIT);
RANGE = EC(OFFSET:OFFSET+LIMIT-1);
GLOBAL = 0.5*(RANGE - prctile(RANGE,25)) / (prctile(RANGE,75) - prctile(RANGE,25)) + 0.25;
GLOBAL(GLOBAL > 1) = 1;
GLOBAL(GLOBAL < 0) = 0;

for limit = 1:LIMIT
    EC_A = prctile(EC(OFFSET:OFFSET+limit-1), 25);
    EC_B = prctile(EC(OFFSET:OFFSET+limit-1), 75);
    LOCAL(limit) = 0.5*(EC(OFFSET+limit-1) - EC_A) / (EC_B - EC_A) + 0.25;
    LOCAL(LOCAL > 1) = 1;
    LOCAL(LOCAL < 0) = 0;
end

ERROR = abs(LOCAL - GLOBAL);
RMSE = sqrt(nanmean((ERROR).^2));

% UNCOMMENT TO DISPLAY RESULTS
%plot(ERROR);
%fprintf('RMSE is: %d\n', RMSE);

end