%% Randomized Pass
%% Randomized n-Pass algorithm of a single field
clc; clear all; close all;

% Import
PASS = input('Pass Length: ');
SAMPLES = input('Passes to Sample: ');
METHODS = 4;
FIELDS = 6;
RESULTS = nan(SAMPLES, FIELDS, METHODS);
headers = {'BR','HE','HU','KR','LU','RA'};

% Randomize samples
for field = 1:FIELDS
    disp(strcat('Select data file for: ', headers(field)));
    [EC1, ~, ~, ~, ~, ~, FILENAME] = import_csv();
    for sample = 1:SAMPLES
        OFFSET = randi(length(EC1)-PASS);
        [r1, ~, ~] = NormalScaling(EC1,OFFSET,PASS);
        [r2, ~, ~] = QuartileScaling(EC1,OFFSET,PASS);
        [r3, ~, ~] = MedianScaling(EC1,OFFSET,PASS);
        [r4, ~, ~] = AdjustedStandardScaling(EC1,OFFSET,PASS);
        RESULTS(sample,field,1) = r1;
        RESULTS(sample,field,2) = r2;
        RESULTS(sample,field,3) = r3;
        RESULTS(sample,field,4) = r4;
    end
end

% Save results
%csvwrite_with_headers(strcat('Scaling-', int2str(PASS), '-', int2str(SAMPLES), '-', FILENAME), RESULTS(:,:,1), headers);
%csvwrite_with_headers(strcat('Quartile_Scaling-', int2str(PASS), '-', int2str(SAMPLES), '-', FILENAME), RESULTS(:,:,2), headers);
csvwrite_with_headers(strcat('Adj_Normalization-', int2str(PASS), '-', int2str(SAMPLES), '-', FILENAME), RESULTS(:,:,3), headers);
%csvwrite_with_headers(strcat('Adj_Standardization-', int2str(PASS), '-', int2str(SAMPLES), '-', FILENAME), RESULTS(:,:,4), headers);

% Build sets
% group = [repmat({'BR'}, SAMPLES, 1);...
%         repmat({'HE'}, SAMPLES, 1);...
%         repmat({'HU'}, SAMPLES, 1);...
%         repmat({'KR'}, SAMPLES, 1);...
%         repmat({'LU'}, SAMPLES, 1);...
%         repmat({'RA'}, SAMPLES, 1);...
%         repmat({'All'}, SAMPLES*FIELDS, 1)];
% set1 =  [RESULTS(:,1,1);...
%         RESULTS(:,2,1);...
%         RESULTS(:,3,1);...
%         RESULTS(:,4,1);...
%         RESULTS(:,5,1);...
%         RESULTS(:,6,1);...
%         reshape(RESULTS(:,:,1), SAMPLES*FIELDS, 1)];    
% set2 =  [RESULTS(:,1,2);...
%         RESULTS(:,2,2);...
%         RESULTS(:,3,2);...
%         RESULTS(:,4,2);...
%         RESULTS(:,5,2);...
%         RESULTS(:,6,2);...
%         reshape(RESULTS(:,:,2), SAMPLES*FIELDS, 1)];
% set3 =  [RESULTS(:,1,3);...
%         RESULTS(:,2,3);...
%         RESULTS(:,3,3);...
%         RESULTS(:,4,3);...
%         RESULTS(:,5,3);...
%         RESULTS(:,6,3);...
%         reshape(RESULTS(:,:,3), SAMPLES*FIELDS, 1)];
% set4 =  [RESULTS(:,1,4);...
%         RESULTS(:,2,4);...
%         RESULTS(:,3,4);...
%         RESULTS(:,4,4);...
%         RESULTS(:,5,4);...
%         RESULTS(:,6,4);...
%         reshape(RESULTS(:,:,4), SAMPLES*FIELDS, 1)];
% 
% % Scaling
% boxplot(set1, group, 'labels', {'BR','HE','HU','KR','LU','RA', 'All'});
% title(strcat('Scaling (',int2str(PASS),' point pass)'));
% ylim([0 1]);
% ylabel('RMSE of Local vs. Global Error');
% xlabel('Fields');
% saveas(gcf, strcat('Scaling-', int2str(PASS), '-', int2str(SAMPLES),'.tif'));
% waitforbuttonpress();
% 
% % Quartile
% boxplot(set2, group, 'labels', {'BR','HE','HU','KR','LU','RA', 'All'});
% title(strcat('Quartile Scaling (',int2str(PASS),' point pass)'));
% ylim([0 1]);
% ylabel('RMSE of Local vs. Global Error');
% xlabel('Fields');
% saveas(gcf, strcat('Quartile_Scaling-', int2str(PASS), '-', int2str(SAMPLES), '.tif'));
% waitforbuttonpress();
% 
% % Adjusted Median
% boxplot(set3, group, 'labels', {'BR','HE','HU','KR','LU','RA', 'All'});
% title(strcat('Adjusted Normalization (',int2str(PASS),' point pass)'));
% ylim([0 1]);
% ylabel('RMSE of Local vs. Global Error');
% xlabel('Fields');
% saveas(gcf, strcat('Adj_Normalization-', int2str(PASS), '-', int2str(SAMPLES),'.tif'));
% waitforbuttonpress();
% 
% % Adjusted Standardization
% boxplot(set4, group, 'labels', {'BR','HE','HU','KR','LU','RA', 'All'});
% title(strcat('Adjusted Standardization (',int2str(PASS),' point pass)'));
% ylim([0 1]);
% ylabel('RMSE of Local vs. Global Error');
% xlabel('Fields');
% saveas(gcf, strcat('Adj_Standardization-', int2str(PASS), '-', int2str(SAMPLES), '.tif'));
% waitforbuttonpress();