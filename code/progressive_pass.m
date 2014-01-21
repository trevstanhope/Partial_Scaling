%% Progressive Pass
%% Progressive analysis of a single field
clc; close all; clear all;

% Import
[EC, ~, ~, ~, ~, ~, FILENAME] = import_csv();
OFFSET = input('Enter offset (default is 1): ');
FIELD = inputdlg('Enter field abbreviation (e.g. BR): ');
LIMIT = length(EC);

% Run Scaling
[r1, e1, g1, l1] = ProgressiveScaling(EC,OFFSET,LIMIT);
[r2, e2, g2, l2] = ProgressiveQuartileScaling(EC,OFFSET,LIMIT);
[r3, e3, g3, l3] = ProgressiveNormalization1(EC,OFFSET,LIMIT);
[r4, e4, g4, l4] = ProgressiveStandardization(EC,OFFSET,LIMIT);

% Display Results
disp(r1);
disp(r2);
disp(r3);
disp(r4);
P = 100*(OFFSET:LIMIT)/LIMIT;
fig1 = figure;
plot(P, e1,'g', P, e2, 'r', P, e3, 'k', P, e4, 'm');
xlabel('Percentage of Field');
ylabel('Absolute Error of Local vs. Global')
ylim([0 1]);
legend({'Scaling', 'Quartile Scaling','Adjusted Normalization','Adjusted Standardization'});
title(strcat('Full Field Progressive Scaling [', FIELD, ']'));
saveas(gcf, strcat('Progressive Error-', FILENAME, '.tif'));
csvwrite_with_headers(strcat('Progressive Error-', FILENAME), [e1',e2',e3',e4'], {'Scaling', 'Quartile Scaling','Adjusted Normalization','Adjusted Standardization'});
waitforbuttonpress();
close();
