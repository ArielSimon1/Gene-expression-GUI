% *** B Mission ***
% this function calculates a global change
% input: Mat = numeric 2d array.
function [sortedChangeLevels,indexArray] = calChange(Mat)
% B1:
temp = linearDistribution(Mat,2); %temp = struct with 2 fields:
% 1) representativeValue, 2) Distibution.
% B2:
levelOfChange = temp.Distribution./temp.representativeValue;
% B3:
% keeps the global change values and the index.
[sortedChangeLevels,indexArray] = sort(levelOfChange,1, 'descend');
