% *** C Mission ***
% This function gets data structure (in process) + index array,
% and returns the input data structure, arranged by indexes.
function [sOutputarranged] = arrangeByIndex(sInputProcessing, indexArray)
% C1: copy the input structure to the output structure
sOutputarranged = sInputProcessing;
% C2: sort expression levels by given index 
sOutputarranged.expressionLevels = sInputProcessing.expressionLevels(indexArray,:);
% C3: sort gene names levels by given index 
sOutputarranged.geneTitles = sInputProcessing.geneTitles(indexArray,:);
end