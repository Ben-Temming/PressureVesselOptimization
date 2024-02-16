%Initialisation 
clc
clear
format compact
format short g
%loading excel data
table = readcell('Assignment1-Table1-Materials.xlsx');
table(1,:)=[]; %remove the text component
%getting an array for Sy and CF
Index_table = table(:,1);
Sy_table = table(:,2);
Sy_table = cell2mat(Sy_table);
t_table = table(:,3);
CF_table = table(:,4);
CF_table = cell2mat(CF_table);
for i=1:length(Index_table)
     material(i).Sy = Sy_table(i)*1e6;
     %convert arrray of t from string to numbers
     t_row = t_table(i);
     t = str2num(t_row{1});
     material(i).t = t*1e-3;
     material(i).CF = CF_table(i);
end
save('Materials.mat','material');