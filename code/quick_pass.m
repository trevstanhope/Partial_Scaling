%% Quick Pass
%% Single pass for a single field's data file.
close all; clc; clear all;

% Import
[EC, ~, ~, ~, ~, ~, FILENAME] = import_csv();
OFFSET = input('Offset: ');
PASS = input('Pass Length (-1 for all): ');
if PASS == -1
    PASS = length(EC)-OFFSET;   
end

% Run scaling
[r1, g1, l1] = NormalScaling(EC,OFFSET,PASS);
[r2, g2, l2] = QuartileScaling(EC,OFFSET,PASS);
[r3, g3, l3] = AdjustedMedianScaling(EC,OFFSET,PASS);
[r4, g4, l4] = AdjustedStandardScaling(EC,OFFSET,PASS);

% Display STD of global
disp(std(g1));
disp(std(g2));
disp(std(g3));
disp(std(g4));

% Display RMSE Change
P = 1:(PASS - OFFSET + 1);
fig1 = figure;
plot(P, r1,'g', P,r2, 'b', P, r3, 'k', P, r4, 'm');
xlabel('Point in Pass');
ylabel('RMSE of Local vs. Global')
ylim([0 1]);
legend({'Scaling', 'Quartile Scaling','Adj. Normalization','Adj. Standardization'});
title(strcat('Full Field Progressive Scaling [', FILENAME, ']'));
saveas(gcf, strcat('Progressive-', FILENAME, '-', '.tif'));
waitforbuttonpress();
close;
