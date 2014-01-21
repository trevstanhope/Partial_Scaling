clc; clear all; close all;

[EC1, ~, ~, ~, ~, ~, FILENAME] = import_csv();
PASS = input('Pass Length: ');
SAMPLES = input('Passes to Sample: ');
METHODS = 8;
RESULTS = zeros(SAMPLES,METHODS);
OFFSETS = zeros(1,SAMPLES);

for sample = 1:SAMPLES
    OFFSET = randi(length(EC1)-PASS);
    [r1 g1 l1] = StandardScaling(EC1,OFFSET,PASS);
    [r2 g2 l2] = NormalScaling(EC1,OFFSET,PASS);
    [r3 g3 l3] = MedianScaling(EC1,OFFSET,PASS);
    [r4 g4 l4] = QuartileScaling(EC1,OFFSET,PASS);
    [r5 g5 l5] = PercentileScaling(EC1,OFFSET,PASS);
    [r6 g6 l6] = ProjectiveScaling(EC1,OFFSET,PASS);
    [r7 g7 l7] = AdjustedMedianScaling(EC1,OFFSET,PASS);
    [r8 g8 l8] = AdjustedStandardScaling(EC1,OFFSET,PASS);
    RESULTS(sample,:) = [r1(end),r2(end),r3(end),r4(end),r5(end),r6(end),r7(end),r8(end)];
    OFFSETS(sample) = OFFSET;
end

boxplot(RESULTS, 'labels', {'Standard','Normal','Median','Quartile','Percentile','Projective','Median 2','Standard 2'});
saveas(gcf, strcat(FILENAME, '.tif'));

