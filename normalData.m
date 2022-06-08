% *** A mission ***
% mat is 2d array. this function normalize the array.
function [normalArray] = normalData(mat,dim)
% the function returns sructure with 2 fields (mean and std) 
sDis = normDis(mat,dim); % normDis finds normal distribution of data array, along a chosen dimention
normalArray = (mat-sDis.representativeValue)./sDis.Distribution;

