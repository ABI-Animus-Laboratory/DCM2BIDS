function [] = writeSourceStructure(regexp,srcfilename)
%regexp='001';
%srcfilename='NOT_DIAGNOSTIC_(Transit_corrected_CBF)_eASL_3_delays_802';
newStr = split(srcfilename,'(');
if length(newStr)>1
    Section1=strcat(newStr{1},'\(');
    newStr2 = split(newStr{2},')');
    Section2=strcat(newStr2{1},'\)');
    Section3=strcat(newStr2{2},'');
    srcfilename=strcat(Section1,Section2,Section3);
end
srcstruct.bMatchDirectories = true;
srcstruct.folderHierarchy = {strcat('^(',regexp,')$'),strcat('^(',srcfilename,')$')};
srcstruct.tokenOrdering = [1,0,0,2];
srcstruct.tokenVisitAliases = [];
srcstruct.tokenSessionAliases = [];
srcstruct.tokenScanAliases = {strcat('^',srcfilename,'$'),"ASL4D"};
encoded=jsonencode(srcstruct,"PrettyPrint",true);
fid = fopen('sourceStructure.json','w');
fprintf(fid,'%s',encoded);
fclose(fid);