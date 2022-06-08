% **A mission**
% this function select and read the data files: metadata file and the
% measurements file of an experiment.
function [Data_structure] = readingDataFile()
% create an empty data structure with proper fields.
Data_structure = struct('metadate_fileName',[],'measurements_fileName',[], 'conditions',[], 'titleConditions',[],'Ntypes',[],'Nrepeats',[],'expressionValue', [],'genesNames',[]);

% **A1** 
% metadata file choosing:
% open a window that asks the user for target file, which ended with suffix "Names.xls" or
% "Names.xlsx".
% "uigetfile" = open file selection dialog box. name1 = name of file
% (tomatoNames.xls), path = path in local computer.
[name1, path] = uigetfile({'*Names.xls';'*Names.xlsx'}); %% '*' means ignore until this point
Data_structure.metadate_fileName = [path name1];

% **A2**
% read the metadata file fields (headers = condition titles) into "textData":
[~, textData] = xlsread(Data_structure.metadate_fileName); %%  '~' do not present

% fill Data_structur fields with metadata_file values:
% **A3** - add title "description" as a string (not cell)
Data_structure.titleConditions = textData{1,1};
% **A4** - add fileds - conditions names
Data_structure.conditions = textData(2:end,1);
% **A5**
Data_structure.Ntypes = length(Data_structure.conditions); %% Nytpes = number of differenet conditions.

% **A6**
% measurments file choosing:
% open a window that asks the user for target file, with the same preffix and path as the metadata file
name2 = split(name1, 'Names');
f1 = [path name2{1} '*.xls'];
[Data_structure.measurements_fileName,path2] = uigetfile({f1},'File Selector');
% create the full path as the "measurements_fileName" field
Data_structure.measurements_fileName = [path2 Data_structure.measurements_fileName];

% **A7** - read the full path in "measurements_fileName" field
% numericData = numeric values in count matrix, textData2 - headers
[numericData, textData2] = xlsread(Data_structure.measurements_fileName); 
% **A8**
% save the expression details in the proper field of Data_structure
Data_structure.expressionValue = numericData;
Data_structure.genesNames = textData2(2:end,1);

% **A9**
% find the total number of repeats:
% (numericData,2) = number of colunms,(numericData,1) = number of rows
Data_structure.Nrepeats = size(numericData,2)/Data_structure.Ntypes;




