% ** C mission **
% this function finds a linear distribution of data array, along a chosen dimention.
% input: dataMat = data array (1d, 2d or 3d), dimIndex = dimention number
function [sDis]= linearDistribution(dataMat, dimIndex)
% calculate the median along the dimIndex, save into "representativeValue"
% fields of "sDis" structre.
sDis.representativeValue = median(dataMat,dimIndex);
% calculate absolute value between input dataMat and representativeValue.
temp = abs(dataMat-sDis.representativeValue);
% calculate the mean of temp along dimIndex, return the result in "Distribution" field.
sDis.Distribution = mean(temp,dimIndex);
