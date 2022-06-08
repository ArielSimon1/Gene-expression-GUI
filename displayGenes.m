
% ** H mission **
% this function graphicly displays the genes.
% input: s = data structure, map = color map.
function [] = displayGenes(s,map)

% ** H1 **
% extract the expression values matrix
genes = s.expressionLevels(1:s.genesNum, :);

% ** H2 **
% create an extended matrix - append last row and column
tmp_matrix = [genes genes(:, end)]; % concatenate the original matrix + right column
extended_matrix = [tmp_matrix ; tmp_matrix(end, :)]; % concatenate tmp_matrix +  bottom row.

% ** H3 **
pcolor(extended_matrix)
shading flat
%shading flat % get rid of the lines
colormap(map)
colorbar; % add legend to the plot

% ** H4 **
xlabel('conditions');
ylabel('geneTitles');

% ** H5 **
title({s.fileNameData ['signal/noise ratio: ' num2str(s.signalToNoise)], ['stand Method: ' s.standMethod]});

% ** H6 **
genesTitles = s.geneTitles(1:s.genesNum);

% ** H7 **
% a:
Axes = gca;
% b:
arr = 1:length(s.conditions);
%arr = (1:1:size(s.expressionLevels, 2)); % 3 = Nrepeats
Axes.XTick = arr + 0.5;
Axes.XTickLabel = s.conditions;
% c: 
%Axes.XTickLabel = arr;
% d:
Axes.YTick=1:length(genesTitles);
Axes.YTickLabel=genesTitles;
