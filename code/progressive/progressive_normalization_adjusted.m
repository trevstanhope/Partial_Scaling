function [RMSE ERROR GLOBAL LOCAL] = progressive_normalization_adjusted(EC, OFFSET, LIMIT)

LOCAL = zeros(1, LIMIT);
RANGE = EC(OFFSET:OFFSET+LIMIT-1);
GLOBAL = (RANGE - min(RANGE))/(2*median(RANGE)- min(RANGE));
GLOBAL(GLOBAL > 1) = 1;
GLOBAL(GLOBAL < 0) = 0;

for limit = 1:LIMIT
    EC_A = min(EC(OFFSET:OFFSET+limit-1));
    EC_B = median(EC(OFFSET:OFFSET+limit-1));
    LOCAL(limit) = (EC(OFFSET+limit-1) - EC_A)/(2*EC_B - EC_A);
    LOCAL(LOCAL > 1) = 1;
    LOCAL(LOCAL < 0) = 0;
end

ERROR = abs(LOCAL - GLOBAL);
RMSE = sqrt(nanmean((ERROR).^2));

% UNCOMMENT TO DISPLAY RESULTS
%plot(ERROR);
%fprintf('RMSE is: %d\n', RMSE);

end