%% Simple Projective
function [RMSE GLOBAL LOCAL] = simple_projective(EC,OFFSET,PASS)

GLOBAL = (EC - min(EC)) / (max(EC) - min(EC));
GLOBAL(GLOBAL > 1) = 1;
GLOBAL(GLOBAL < 0) = 0;

% Determine Distribution
EC_S = std(EC(OFFSET:OFFSET+PASS));
EC_K = skewness(EC(OFFSET:OFFSET+PASS));

% Determine Minima
EC_B = min(EC(OFFSET:OFFSET+PASS));
P_B = round2(invprctile(EC,EC_B), 5)/100;
if P_B == 0
	STD_A = -2.33;
else
	STD_A = norminv(P_B,0,1);
end
EC_A = EC_B + (-2.33-STD_A)*(EC_S);
    
% Determine Maxima
EC_Y = max(EC(OFFSET:OFFSET+PASS));
P_Y = round2(invprctile(EC,EC_Y), 5)/100;
if P_Y == 0
    STD_Z = 2.33;
else
    STD_Z = norminv(P_Y,0,1);
end
EC_Z = EC_Y + (2.33-STD_Z)*(EC_S);
    
LOCAL = (EC - EC_A) / (EC_Z - EC_A);
LOCAL(LOCAL > 1) = 1;
LOCAL(LOCAL < 0) = 0;
RMSE = sqrt(nanmean((LOCAL-GLOBAL).^2));
    
% UNCOMMENT TO DISPLAY RESULTS
% plot(RMSE);
% disp(min(GLOBAL));
% disp(max(GLOBAL));
% disp(EC_A);
% disp(EC_Z);

end
