% ** D mission **
% this function finds normal distribution of data array, along a chosen dimention.
function [sDis] = normDis(dataMat, dimIndex)
% calculate the mean of dataMat along dimIndex, put the result in "representativeValue" field.
sDis.representativeValue = mean(dataMat, dimIndex);
% std = standart division matlab command. template: S = std(A,w,dim).
% When w = 0 (default), S is normalized by N-1.
% When w = 1, S is normalized by the number of observations, N.
sDis.Distribution = std(dataMat, 1, dimIndex);