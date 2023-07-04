varNames={'ID','type','acq','session','contrast','task','run'};
[init_type{1:80,1}]=deal('');
cnames = categorical(init_type,{'anat','flow','perf','func','fmap','moti'});
varTypes={'string','categorical','string','string','string','string','string'};
%Table = table(ScanName,type,acq,session,contrast,task,run);
Table=table('Size',[80,length(varNames)],'VariableNames',varNames,'VariableTypes',varTypes);
Table.type=cnames;
                %%

fig = uifigure;
cnames = categorical({},{'anat','flow','perf','func','fmap','moti'});
w = [[]];
tdata = table(cnames,w,'VariableNames',{'Color','Wavelength'});
uit = uitable(fig,'Data',tdata,'ColumnEditable',true);
%%
root_dir = pwd;
bidsProject = 'DTDS';
%mkdir(fullfile(root_dir, bidsProject));
bids_participants_name = 'participants.tsv';

participant_id = ['sub-001'; 'sub-002'];
age = [28 55]';
sex = ['m';'m'];

t = table(participant_id,age,sex);
writetable(t, fullfile(pwd, bids_participants_name), ...
              'FileType', 'text', ...
              'Delimiter', '\t');
%%
close all
clear all
DD.Name = 'DTDS Demographics';
DD.age = 'Age of participant';
DD.sex = {'sex of participant';'male=m';'female=f'};
encoded=jsonencode(DD,PrettyPrint=true);
fid = fopen('participants.json','w');
fprintf(fid,'%s',encoded);
fclose(fid);
