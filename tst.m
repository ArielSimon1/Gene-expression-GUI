% this script is a tester script to the missions A, C, D etc.

% ** B mission (test A mission) **
% call the function and keep the answer in "experimentData"
experimentData = readingDataFile();

% ** E mission (test C,D missions) **
% create a random table of 4 columns X 10 rows, max number = 7
testMat = randi(7,10,4);
% call function of C mission for 1d
[sDis] = linearDistribution(testMat,1);
% call function of D mission for 2d
[sDis] = normDis(testMat,2);

% ** G mission (test F mission) **
s = struct('signalToNoise',[],'genesNum',[], 'expressionLevels',[], 'fileNameData',[],'geneTitles',[],'titleConditions',[],'conditions', [],'standMethod',[],'processStep',[]);
% initilize the fields:
s.standMethod = 'none';
s.processStep = 'raw';
s.signalToNoise = 4;
s.genesNum = 30;
% call the function:
output = DataProcessing(s);

% ** I mission (test H mission) **
test = output;
test.processStep = 'function check';
% take only data from the first repeat of the experiment - first colunm of
% each repeat, like: (:, 1:3:15)
tmp = experimentData.expressionValue(:,1:experimentData.Nrepeats:(experimentData.Nrepeats*experimentData.Ntypes));
test.expressionLevels = tmp(1:s.genesNum,:); % take only the first "genesNum" genes
test.geneTitles = experimentData.genesNames(1:s.genesNum);
test.titleConditions = experimentData.titleConditions;
test.conditions = experimentData.conditions;
displayGenes(test, 'spring')

% ** K mission (test J mission) **
repeatStatsCheck = repeatStats(experimentData);