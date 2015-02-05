%% Simple Parameters
function [MEDIAN MEAN MIN MAX STD PERCENT25 PERCENT75] = simple_parameters(EC,OFFSET,PASS)

MEDIAN = median(EC) - median(EC(OFFSET:OFFSET+PASS));
MEAN = mean(EC) - mean(EC(OFFSET:OFFSET+PASS));
MIN = min(EC) - min(EC(OFFSET:OFFSET+PASS));
MAX = max(EC) - max(EC(OFFSET:OFFSET+PASS));
STD = std(EC) - std(EC(OFFSET:OFFSET+PASS));
PERCENT25 = prctile(EC,25) - prctile(EC(OFFSET:OFFSET+PASS),25);
PERCENT75 = prctile(EC,75) - prctile(EC(OFFSET:OFFSET+PASS),75);

end