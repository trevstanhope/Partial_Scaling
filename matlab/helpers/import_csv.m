%% Import Data
function [EC1 EC2 Z ID X Y FILENAME] = import_csv()
    FILENAME = uigetfile('.csv');
    raw = csvread(FILENAME);
    ID = raw(:,1)';
    X = raw(:,2)';
	Y = raw(:,3)';
    EC1 = raw(:,4)';
    EC2 = raw(:,5)';
    Z = raw(:,6)';
end

