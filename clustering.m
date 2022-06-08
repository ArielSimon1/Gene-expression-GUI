% *** C mission ***
% this function cluster the gene expression (creates groups)
function [indexGenes] = clustering(Data_structure,groups_num,degreeOfChange)
% C1 - calculate k-means according to the chosen groups_num 
cluster = kmeans(Data_structure.expressionLevels,groups_num);
% C2
cluster_new = (cluster + degreeOfChange./(2.*(max(degreeOfChange))));
% C3
[a, indexArray] = sort(cluster_new);
% C4
temp = arrangeByIndex(Data_structure,indexArray);
% C5
displayGenes(temp,spring);
% c6a:
temp_sort_index = sort(cluster);
% c6b - concatinate 1 to the arr for the next step
new_val = 1;
check = [new_val, temp_sort_index.'];
location = (check(1:end-1) == temp_sort_index.');
% turning 0 to 1 and 1 to 0
location = ~location;
location =find(location);
% c6c:
for b = location(1:end)
   l = line([1, length(Data_structure.conditions)+1],[b,b]);
   l(1).LineWidth = 3;
end
% c7
% find indexes of genes (rows of genes) in "cluster" array that belongs to each group.
indexGenes = cell([1 groups_num]);
for a = 1:groups_num
    logical = (cluster == a);
    indexGenes{a} = find(logical);
end