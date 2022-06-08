% ** J mission **
function [sStatProcesss] = repeatStats(sData)
% ** J1 **
% "reshape" command arranges the data as 3d structure: N * Ntypes * Nrepeats 
data = (reshape(sData.expressionValue,length(sData.expressionValue),sData.Ntypes, sData.Nrepeats));
% ** J2 **
% return the answer of "linear distribution" function, along the 3d of "data":
sStatProcesss = linearDistribution(data, 3);

