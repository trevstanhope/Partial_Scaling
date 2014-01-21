function [RMSE GLOBAL LOCAL] = ProjectiveScaling(EC,OFFSET,PASS)

RMSE = zeros(1,PASS);
GLOBAL = (EC - min(EC)) / (max(EC) - min(EC));
GLOBAL(GLOBAL > 1) = 1;
GLOBAL(GLOBAL < 0) = 0;

for limit = 1:PASS
    % Distribution
    EC_S = std(EC(OFFSET:OFFSET+limit));
%     EC_K = skewness(EC(OFFSET:OFFSET+limit));
    
    % Minima
    EC_B = min(EC(OFFSET:OFFSET+limit));
    P_B = round2(invprctile(EC,EC_B), 5)/100;
    if P_B == 0
    	STD_A = -2.33;
    else
        STD_A = norminv(P_B,0,1);
    end
    EC_A = EC_B + (-2.33-STD_A)*(EC_S);
%     disp(EC_A);
    
    % Maxima
    EC_Y = max(EC(OFFSET:OFFSET+limit));
    P_Y = round2(invprctile(EC,EC_Y), 5)/100;
    if P_Y == 0
    	STD_Z = 2.33;
    else
        STD_Z = norminv(P_Y,0,1);
    end
    EC_Z = EC_Y + (2.33-STD_Z)*(EC_S);
%     disp(EC_Z);
    
    LOCAL = (EC - EC_A) / (EC_Z - EC_A);
    LOCAL(LOCAL > 1) = 1;
	LOCAL(LOCAL < 0) = 0;
    RMSE(limit) = sqrt(nanmean((LOCAL-GLOBAL).^2));
    
end

% UNCOMMENT TO DISPLAY RESULTS
% plot(RMSE);
% disp(min(GLOBAL));
% disp(max(GLOBAL));

end
