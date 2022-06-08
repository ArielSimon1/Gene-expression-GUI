% *** Project's Main Script *** %

% A1 - clean workspace.
clear all
close all

% A2 - load raw data by using readingDataFile script.
rawData = readingDataFile();

% A3 - call repeatStats for rawData
statOfRep = repeatStats(rawData);

% A4 - initilize data structure with 30 genes, signal-to-noise ratio = 4 
% create an empty structure
sProcess = struct('signalToNoise',[],'genesNum',[], 'expressionLevels',[], 'fileNameData',[],'geneTitles',[],'titleConditions',[],'conditions', [],'standMethod',[],'processStep',[]);
% initialize the fields:
sProcess.signalToNoise = 4;
sProcess.genesNum = 30;
sProcess.expressionLevels = statOfRep.representativeValue;
sProcess.fileNameData = rawData.measurements_fileName;
sProcess.geneTitles = rawData.genesNames;
sProcess.titleConditions = rawData.titleConditions;
sProcess.conditions = rawData.conditions;
sProcess.standMethod = 'none';
sProcess.processStep = 'unfiltered';

% *** D Mission ***
% D1 - call the function "calChange" - that calculates global change and
% index
[ans, indexArray] = calChange(sProcess.expressionLevels);
% D2 - call the function "arrangeByIndex" to sort genes and their expression values by the
% indexes of global-change
tmp = arrangeByIndex(sProcess, indexArray);
% D3 - display gene expression according to the global change levels.
figure(1)
displayGenes(tmp, 'spring');

% *** F mission ***
% F1 - call the function "signalToNoise" that calculates the ratio of
% signal to noise (statsOfRep = repeatStats(rawData))
check = signalToNoise(statOfRep);
% F2
figure(2)
% create of histogram gaps =
% 31 gaps, the min value is 2, the max value is the max value of check. 
histo_arr = linspace(2,max(check),31);
histogram(check,histo_arr);
xlabel('Siganl To Noise Ratio');
ylabel('Gene Number');
title('Info for choosing signal-to-noise ratio treshold:');

% F3 - call "DataProcessing" function - update status of processing
sProcess = DataProcessing(sProcess);
% F4 - get indexs of significant values
logic_arr = (sProcess.signalToNoise <= check);
% F5
% get only gene expression of genes with ratio over the treshold
sProcess.expressionLevels = sProcess.expressionLevels(logic_arr,:);
% F6
% get only genes names with ratio over the treshold
sProcess.geneTitles = sProcess.geneTitles(logic_arr);
% F7 - check if number of significant genes is lower than user's expectation 
if length(sProcess.geneTitles) < sProcess.genesNum
    tmp = length(sProcess.geneTitles); % for example: 14 1
    sProcess.genesNum = tmp(1);
end
% F8 - upload the status of process:
sProcess.processStep = 'filtered';
% F9 - call calChange to calculate global change and get the indexes of the
% filtered expression levels (only 14 significant)
[sortedChangeLevel, indexArray] = calChange(sProcess.expressionLevels);
% F10 - call arrangeByIndex function to sort sProcess
sProcess = arrangeByIndex(sProcess, indexArray);
% F11 - display genes (if array element are not only 0)
% if all values are 0, it means there are no significant genes.
if any(logic_arr)
    clf(figure(2))
    displayGenes(sProcess, 'spring')
end

% ******* FINAL PART *******
% ** Scale, Normalize by clustering
% *** D Mission ***
% D1
figure(3)
% D2 - create list selection dialog box
list = {'Normalization','Scaling'};
selection = listdlg('ListString',list);
% D3
sProcess.genesNum = size(sProcess.expressionLevels,1);
% D4 
sCluster = sProcess;
while true
    answer = inputdlg('Enter number of groups:');
    answer = str2num(answer{1});
    if selection == 1
        sCluster.standMethod = 'normalized';
        sCluster.expressionLevels = normalData(sCluster.expressionLevels,1);
    elseif selection == 2
        sCluster.standMethod = 'scaled';
        sCluster.expressionLevels = scaling(sCluster.expressionLevels,1);
    else
        sCluster.standMethod = 'none';
    end
clf % clean the window
clusterResults = clustering(sCluster,answer,sortedChangeLevel);
list = {'Normalization','Scaling','Stop'};
selection2 = listdlg('ListString',list);
if selection2 == 3
  break
end
end

% *** E mission - BoxPlot ***
geneNames = cell(1,answer); % answer = number of groups as the user ask for
figure(4)
linesNum = round(answer/2); % get number of rows in figure(4)
for c= 1:answer % organize the empty cell "geneNames" with
    % the gene names and their expression levels
    geneNames{c} = sCluster.geneTitles(clusterResults{c});
    geneExp = sCluster.expressionLevels(clusterResults{c},:);
    subplot(linesNum, 2, c);
    boxplot(geneExp);
    if c == 1
        title({sCluster.fileNameData ['signal/noise ratio: ' num2str(sCluster.signalToNoise)]});
    end
    if c == 2
       title({['stand Method: ' sCluster.standMethod]}); 
    end
    Axes = gca;
    Axes.XTick = 1:length(sCluster.conditions) ;
    Axes.XTickLabel = sCluster.conditions;
    ylabel(['Group Number: ' num2str(c)]);
end