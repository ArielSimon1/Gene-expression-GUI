% ** F mission **
% input: structure for data processing "sInputProcessing"
function [sOutputProcessing] = DataProcessing(sInputProcessing)

% ** F1 **
% initialize titles to the user input box:
fields_title = {'Enter signal to noise ratio', 'Enter number of genes'};

% ** F2 **
% default = default values to display in the user input box - the fileds of
% "sInputProcessing" - signalToNoise, genesNum.
default = {num2str(sInputProcessing.signalToNoise),num2str(sInputProcessing.genesNum)};

% ** F3 **
% copy the input argument to the output argument
sOutputProcessing = sInputProcessing;

% * F4 - a,b,c,d **
% inputdlg = create dialog box to gather user input
while true

    % a: display the user input box, keep the input into "inputs".
    % "default" = the signalToNoise, genesNum default values.
    inputs = inputdlg(fields_title,'', 1 ,default); % '1' is the defualt for 'dim'

    % b: covnert the input strings to numeric.
    sOutputProcessing.signalToNoise = str2num(inputs{1});
    sOutputProcessing.genesNum = str2num(inputs{2});

    % c: check the converted values. if numeric (no NaN / empty) -> break.
    SNRvalid = ~isempty(sOutputProcessing.signalToNoise) && ~isnan(sOutputProcessing.signalToNoise);
    genesNumValid = ~isempty(sOutputProcessing.genesNum) && ~isnan(sOutputProcessing.genesNum);
    if SNRvalid && genesNumValid
        break
    end
    % d: display error message if NaN / empty:
    if ~SNRvalid
        default{1} = 'Invalid value';
    else 
        default{1} = num2str(sOutputProcessing.signalToNoise);
    end
    if ~genesNumValid
        default{2} = 'Invalid value';
    else
        default{2} = num2str(sOutputProcessing.genesNum);
    end
    % ** F5 **
end

