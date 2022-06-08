% *** B mission ***
% mat is 2d array. this function scaling the array.
function [scaledArray] = scaling(mat,dim)
minMat = min(mat,[],dim); % returns the min of mat along the dimension "dim"
maxMat = max(mat,[],dim); % returns the max of mat along the dimension "dim"
% normalize:
scaledArray = (mat-minMat)./(maxMat-minMat);

