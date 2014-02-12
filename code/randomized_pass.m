%% Randomized Pass
% Randomized n-Pass algorithm comparison of all fields

%% Setup
clc;
clear all;
close all;
PASS_MIN = input('Minimum number of sampled points per pass (PASS_MIN): ');
PASS_MAX = input('Maximum number of sampled points per pass (PASS_MAX): ');
INTERVAL = input('Interval between pass lengths (INTERVAL): ');
SAMPLES = input('Number of samples per pass length (SAMPLES): ');
METHODS = 4;
PARAMETERS = 7; % number of scaling parameters being considered

%% Get Field EC Data
DATA = struct('BR',[],'HE',[],'HU',[],'KR',[],'LU',[],'RA',[]);
FIELDNAMES = {'BR','HE','HU','KR','LU','RA'};
FIELDS = fieldnames(DATA);
for field = 1:numel(FIELDS)
    fprintf('Select data file for field #%d --> ', field);
    [EC, ~, ~, ~, ~, ~, FILENAME] = import_csv();
    disp(FILENAME);
    DATA.(FIELDS{field}) = EC;
end

%% Random Sampling
fprintf('\nRunning Pass Randomization... \n');
PASSES = (PASS_MAX - PASS_MIN)/INTERVAL; % the number of pass lengths sampled
RESULTS = nan(length(FIELDS), SAMPLES, PASSES, METHODS); % RMSE of methods for all fields
VALUES = nan(length(FIELDS), SAMPLES, PASSES, PARAMETERS); % Average values for scaling parameters
for field = 1:numel(FIELDS)
    fprintf('Field (#): %d \n', field);
    data = DATA.(FIELDS{field}); % store the data for each field in 'data'
    
    % For each pass length...
    for pass = 1:((PASS_MAX - PASS_MIN)/INTERVAL) % the index number of the pass length
        pass_length = PASS_MIN + pass*INTERVAL; % the length of the pass
        fprintf('Pass Length (seconds): %d \n', pass_length);
        
        % Randomize the sample offset.
        for sample = 1:SAMPLES
            
            % Get values for a random section of the field
            offset = randi(length(data) - pass_length); % position in field is gaussian randomized
            [MEDIAN, MEAN, MIN, MAX, STD, PERCENT25, PERCENT75] = simple_parameters(data, offset, pass_length);
            [R1, ~, ~] = simple_scaling(data, offset, pass_length);
            [R2, ~, ~] = simple_quartile(data, offset, pass_length);
            [R3, ~, ~] = simple_normalization(data, offset, pass_length);
            [R4, ~, ~] = simple_standardization_adjusted(data, offset, pass_length);
            
            % Save RMSE values to huge matrix
            RESULTS(field, sample, pass, 1) = R1;
            RESULTS(field, sample, pass, 2) = R2;
            RESULTS(field, sample, pass, 3) = R3;
            RESULTS(field, sample, pass, 4) = R4;
            
            % Save paramter values to huge matrix
            VALUES(field, sample, pass, 1) = MEDIAN;
            VALUES(field, sample, pass, 2) = MEAN;
            VALUES(field, sample, pass, 3) = MIN;
            VALUES(field, sample, pass, 4) = MAX;
            VALUES(field, sample, pass, 5) = STD;
            VALUES(field, sample, pass, 6) = PERCENT25;
            VALUES(field, sample, pass, 7) = PERCENT75;
        end    
    end
end

%% Write to File
% Save results to Excel

% Methods
for pass = 1:PASSES
    for method = 1:METHODS
        pass_length = PASS_MIN + pass*INTERVAL;
        xlswrite(strcat('Method_', int2str(method), ' (', date,')'), FIELDNAMES, int2str(pass_length), 'A1');
        xlswrite(strcat('Method_', int2str(method), ' (', date,')'), RESULTS(:,:,pass,method)', int2str(pass_length), 'A2');
    end
end

% Parameters
for pass = 1:PASSES
    for parameter = 1:PARAMETERS
        pass_length = PASS_MIN + pass*INTERVAL;
        xlswrite(strcat('Parameter_', int2str(parameter), ' (', date,')'), FIELDNAMES, int2str(pass_length), 'A1');
        xlswrite(strcat('Parameter_', int2str(parameter), ' (', date,')'), VALUES(:,:,pass,parameter)', int2str(pass_length), 'A2');
    end
end

%% Display Results
% This section can be commented out because boxplot rendering can be done
% in Microsoft Excel.

% % Build sets
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
