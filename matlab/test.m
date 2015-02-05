%% Test
% Simple test script to import data files

%% Setup
clc;
clear all;
close all;

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

