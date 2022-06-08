% *** E Mission ***
% calculate a signal to noise ratio
function [SNR] = signalToNoise(statOfRep)
% E1 - maxNoise showes the max noise for each gene.
maxNoise = max(statOfRep.Distribution, [],2);
% E2 - temp is a structure with 2 fields: Distribution and
% representativeValue
temp = linearDistribution(statOfRep.representativeValue,2);
% E3 - we got SNR = signal noise ratio for each gene
SNR = temp.Distribution./maxNoise;
